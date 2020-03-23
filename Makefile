SRCS	= mkhomedir.c

OBJS	= ${SRCS:.c=.o}

NAME	= mkhomedir
SSHRC	= sshrc

DESTDIR	= /usr/local/bin
DESTSSH = /etc/ssh

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
	CFLAGS += -D OSX
endif

LDFLAGS = 

CC	= cc
RM	= rm -f

${NAME}:	${OBJS}
		${CC} -o ${NAME} ${OBJS} ${LDFLAGS}

all:		${NAME}

clean:
		${RM} ${OBJS}

fclean:		clean
		${RM} ${NAME}

re:		fclean all

.PHONY:		all clean fclean re

install:	${NAME}
		install -d $(DESTDIR)
		install -m 4711 ${NAME} $(DESTDIR)/
		install -d $(DESTSSH)
		install -m 755 ${SSHRC} $(DESTSSH)/
