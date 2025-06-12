# Los estudiantes deberán utilizar los comandos aprendidos en las diferentes guías prácticas para crear
# automatizaciones mediante shell scripting.
 
# 4. Gestor de usuarios y permisos
# a) Listar usuarios
# b) Crear usuario
# c) Modificar usuario tanto permisos como información, o nombre, ID, etc.
# d) Mostrar información de usuario
# e) Manejo de errores
# f) Cambiar pass

numero=0

while [ $numero -ne 7 ]; do

 echo "-- GESTOR DE USUARIOS Y PERMISOS --"

    echo "Elija algunas de las siguientes opciones"
    echo "1- Listar usuarios."
    echo "2- Crear usuario."
    echo "3- Modificar permisos de usuario"
    echo "4- Modificar información de ususario"
    echo "5- Mostrar informacion de usuario."
    echo "6- Cambiar password."
    echo "7- Salir."
    read numero

    case $numero in
        1)  echo "Elegiste la opción 1: Listar usuarios."
            echo "El sistema tiene los siguientes usuarios:"
            cat /etc/passwd
             ;;

        2)  echo "Elegiste la opción 2: Crear usuario."
            echo "Ingrese su nombre:"
            read nombre

            echo "Ingrese nombre de usuario"
            read user

            echo "Ingrese la constraseña"
            read -s password
            password_encriptada=$(openssl passwd -6 "$password")

            # chequeo de q no exista el user
            if id "$user" &>/dev/null; then
                echo "Error: El usuario '$user' ya existe."
                 continue
            fi

            if useradd -c "$nombre" -m "$user" -p "$password_encriptada"; then

                echo "Usuario $user creado correctamente."
            else
                echo "error al crear el usuario"
                continue
            fi

            usermod -aG sudo "$user"
   
            ;;

        3)  echo "Elegiste la opción 3: Modificar permisos de usuario"
            read -p "Nombre de usuario a modificar permisos: " usuario

            if ! grep -q "^$usuario:" /etc/passwd; then
                echo "Error: el usuario '$usuario' no existe." >&2
                continue
            fi

            home_dir=$(getent passwd "$usuario" | cut -d: -f6)
            if [ -z "$home_dir" ] || [ ! -d "$home_dir" ]; then
                echo "Error: no se encontró el directorio home de '$usuario'." >&2
                continue
            fi

            echo "Opciones de permisos para '$home_dir':"
            echo "  1) Cambiar a 755 (rwxr-xr-x)"
            echo "  2) Cambiar a 775 (rwxrwxr-x)"
            echo "  3) Cambiar a 777 (rwxrwxrwx)"
            read -p "Elige una opción (1-3): " opcion

            case "$opcion" in
                1) chmod 755 "$home_dir" ;;
                2) chmod 775 "$home_dir" ;;
                3) chmod 777 "$home_dir" ;;
                *) echo "Opción inválida." >&2; continue ;;
            esac

            if [ $? -eq 0 ]; then
                echo "Permisos modificados correctamente."
                ls -ld "$home_dir"
            else
                echo "Error al cambiar los permisos." >&2
            fi
            ;;

        4)  echo "Elegiste la opción 4: Modificar nombre de usuario"
            read -p "Nombre actual: " usuario
            if ! grep -q "^$usuario:" /etc/passwd; then
                echo "Error: el usuario '$usuario' no existe." >&2
                continue
            fi
            read -p "Nuevo nombre: " nuevo_nombre
            if grep -q "^$nuevo_nombre:" /etc/passwd; then
                echo "Error: ya existe un usuario con ese nombre." >&2
            else
                sudo usermod -l "$nuevo_nombre" "$usuario"
                echo "Usuario renombrado a '$nuevo_nombre'."
            fi
            ;;

        5)  echo "Elegiste la opción 5: Mostrar informacion de usuario"
            read -p "Ingrese el nombre del usuario: " usuario

            if id "$usuario" >/dev/null 2>&1; then
                echo "Información del usuario '$usuario':"
                getent passwd "$usuario"
                id "$usuario"
            else
                echo "Error: El usuario '$usuario' no existe."
            fi

            ;;


        6)  echo "Elegiste la opción 6: Cambiar password"
            read -p "Ingrese el nombre del usuario: " usuario

            if id "$usuario" >/dev/null 2>&1; then
                echo "Cambiando contraseña para '$usuario'."
                sudo passwd "$usuario"
                if [ $? -ne 0 ]; then
                    echo "Error: No se pudo cambiar la contraseña de '$usuario'."
                else
                    echo "Contraseña cambiada correctamente."
                fi
            else
                echo "Error: El usuario '$usuario' no existe."
            fi

            ;;


        7) echo "Saliendo"
            exit 0
        ;;

        *) echo "Ingrese un numero entre 1 y 7"
        ;;
    esac
done