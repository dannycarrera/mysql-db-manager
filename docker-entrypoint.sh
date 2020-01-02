#!/bin/sh

create_db(){
    if [ -n "$MYSQL_DATABASE" ]; then
        echo "Creating database $MYSQL_DATABASE"
        mysql -h${MYSQL_HOST} -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE ;"
    else
        echo "MYSQL_DATABASE not provided"
    fi
}

delete_db(){
    if [ -n "$MYSQL_DATABASE" ]; then
        echo "Deleting database $MYSQL_DATABASE"
        mysql -h${MYSQL_HOST} -uroot -p${MYSQL_ROOT_PASSWORD} -e "DROP DATABASE $MYSQL_DATABASE ;"
    else
        echo "MYSQL_DATABASE not provided"
    fi
}

create_user(){
    if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_PASSWORD" ]; then
        echo "Creating user $MYSQL_USER"
        mysql -h${MYSQL_HOST} -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;"
    
        if [ -n "$MYSQL_DATABASE" ]; then
            echo "Giving user $MYSQL_USER access to schema $MYSQL_DATABASE"
            mysql -h${MYSQL_HOST} -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%' ;"
        fi
    
    else
        echo "MYSQL_USER OR MYSQL_PASSWORD not provided"
    fi
}

delete_user(){
    if [ -n "$MYSQL_USER" ]; then
        echo "Deleting user $MYSQL_USER"
        mysql -h${MYSQL_HOST} -uroot -p${MYSQL_ROOT_PASSWORD} -e "DROP USER'$MYSQL_USER'@'%' ;"
    else
        echo "MYSQL_USER not provided"
    fi
}



### Main Script Starts Here ###

# Check for required variables
if [ -z "$MYSQL_HOST" ]; then
    echo "MYSQL_HOST not provided."
    exit 1
fi

if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
    echo "MYSQL_ROOT_PASSWORD not provided."
    exit 1
fi

if [ -z "$ACTION_DB" ] && [ -z "$ACTION_USER" ]; then
    echo "No Actions provided."
    exit 1
fi

## run functions based on actions
if [ -n "$ACTION_DB" ]; then
    if [ "$ACTION_DB" = "create" ]; then
        create_db
    elif [ "$ACTION_DB" = "delete" ]; then
        delete_db
    fi
fi

if [ -n "$ACTION_USER" ]; then
    if [ "$ACTION_USER" = "create" ]; then
        create_user
    elif [ "$ACTION_USER" = "delete" ]; then
        delete_user
    fi
fi

echo Finished!