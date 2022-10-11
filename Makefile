# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vduchi <vduchi@student.42barcelon>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/05/22 22:11:19 by vduchi            #+#    #+#              #
#    Updated: 2022/10/04 16:07:42 by vduchi           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME 		=	fractol

SRCSDIR		=	src
OBJDIR		=	obj
DIRS		=	include/ libft/ mlx/ ft_printf/include/

LIBFT		=	libft.a
MLX			=	libmlx.a
PRINTF		=	libftprintf.a

HEAD		=	include/fractol.h
SRCS		=	src/main.c src/window.c src/mandelbrot.c src/zoom.c
#OBJS		=	$(patsubst $(SRCSDIR)/%,$(OBJDIR)/%,$(SRCS:.c=.o))

CFLAGS		+= 	-Wall -Werror -Wextra -O3 $(addprefix -I , $(DIRS))
LDFLAGS		= 	-L. -lft -lmlx -lftprintf -framework OpenGL -framework AppKit

#$(OBJDIR)/%.o :	$(SRCSDIR)/%.c
#	gcc $(CFLAGS) -fsanitize=address -g -O $< -o fractol

all:			$(LIBFT) $(MLX) $(PRINTF) $(NAME)

$(NAME): $(SRCSDIR) $(HEAD) $(OBJDIR) $(OBJS)
	gcc $(CFLAGS) $(LDFLAGS) $(SRCS) -o $@
	@echo "Executable created!"
#	gcc $(CFLAGS) -fsanitize=address -g -O3 -fno-omit-frame-pointer $(LDFLAGS) $(SRCS) -o $@

$(LIBFT):
	@make -C libft all
	@mv libft/libft.a .

$(MLX):
	@make -C mlx all
	@mv mlx/libmlx.a .

$(PRINTF):
	@make -C ft_printf all
	@mv ft_printf/libftprintf.a .

$(OBJDIR):
	@mkdir $@
	@echo Obj folder created!

clean:
	@rm -rf $(OBJDIR)

fclean: 		clean
	@rm -f $(NAME) $(LIBFT) $(MLX)
	@make -C libft fclean
	@make -C mlx clean
	@make -C ft_printf fclean
	@echo "All files cleaned"

re: 		fclean all

#leaks:
#	leaks -atExit -- "nombre del executable" "nombre de argumentos"
#
#valgrind:
#	valgrind --leak-check=yes --show-leak-kinds=all "nombre del executable" "nombre de argumentos"
#	valgrind --leak-check=yes --track-origins=yes "nombre del executable" "nombre de argumentos"
#

.PHONY: all clean fclean re