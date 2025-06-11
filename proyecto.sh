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
            
            ;;

        3)  echo "Elegiste la opción 3: Modificar permisos de usuario"
           
            ;;

        4)  echo "Elegiste la opción 4: Modificar informacion de usuario"

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