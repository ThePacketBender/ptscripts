#define _GNU_SOURCE

#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/sendfile.h>
#include <sys/syscall.h>

#include <linux/memfd.h>


#   Load an ELF without touching the disk


#define TARGET "/usr/bin/id"
#define NAME   "AAAA"

size_t sendfile_all(
	int fd_in,
	int fd_out,
	size_t sz)
{
	size_t total = 0;

	while (total < sz) {
		const ssize_t r = sendfile(fd_out, fd_in, NULL, sz);
		
		if (r < 0) {
			if (errno == EAGAIN)
				continue;

			perror("sendfile");
			exit(EXIT_FAILURE);
		}

		total += r;
	}

	return total;
}

int main() {
	const int bin_fd = open(TARGET, O_RDONLY);

	if (bin_fd < 0) {
		perror("open");
		exit(EXIT_FAILURE);
	}

	const int new_fd = syscall(SYS_memfd_create, NAME, MFD_CLOEXEC);

	if (new_fd < 0) {
		perror("memfd_create");
		exit(EXIT_FAILURE);
	}

	struct stat stat;

	if (fstat(bin_fd, &stat) < 0) {
		perror("fstat");
		exit(EXIT_FAILURE);
	}

	sendfile_all(bin_fd, new_fd, stat.st_size);

	if (close(bin_fd) < 0) {
		perror("close");
		exit(EXIT_FAILURE);
	}

	char *new_argv[] = { NAME, NULL };
	char *new_envp[] = { NULL };

	fexecve(new_fd, new_argv, new_envp);

	perror("fexecve");
	exit(EXIT_FAILURE);
}
