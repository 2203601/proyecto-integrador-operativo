# Los estudiantes deberán utilizar los comandos aprendidos en las diferentes guías prácticas para crear
# automatizaciones mediante shell scripting.
 
# 4. Gestor de usuarios y permisos
# a) Listar usuarios
# b) Crear usuario
# c) Modificar usuario tanto permisos como información, o nombre, ID, etc.
# d) Mostrar información de usuario
# e) Manejo de errores
# f) Cambiar pass


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
            echo "La  fecha de hoy es: "$(date) 
             ;;

        2)  echo "Elegiste la opción 2: Crear usuario."
            echo "Los usuarios conectados son:"
            who
            ;;

        3)  echo "Elegiste la opción 3: Modificar permisos de usuario"
            echo "El espacio en el disco es de:" 
            df -h
            ;;

        4)  echo "Elegiste la opción 4: Modificar informacion de usuario"
            echo "El espacio en el disco es de:" 
            df -h
            ;;
        5)  echo "Elegiste la opción 5: Mostrar informacion de usuario"
            echo "El espacio en el disco es de:" 
            df -h
            ;;

        6)  echo "Elegiste la opción 6: Cambiar password"
            echo "El espacio en el disco es de:" 
            df -h
            ;;

        7) echo "Saliendo"
            exit 0
        ;;

        *) echo "Ingrese un numero entre 1 y 7"
        ;;
    esac