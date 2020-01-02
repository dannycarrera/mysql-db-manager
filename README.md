# mysql-db-manager
A docker image for creating or deleting databases and users on an existing mysql database server

## Usage
### Required Environment Variables
- `MYSQL_HOST` - The name of the container which is running mysql

### Database Actions
#### Create
To create a database, 2 env vars need to be set
1. `ACTION_DB` set to `create`
2. `MYSQL_DATABASE` set to the name of the new database

#### Delete
To create a database, 2 env vars need to be set
1. `ACTION_DB` set to `delete`
2. `MYSQL_DATABASE` set to the name of the database to be deleted

### User Actions
#### Create
To create a user, 3 env vars need to be set
1. `ACTION_USER` set to `create`
2. `MYSQL_USER` set to the name of the new user
3. `MYSQL_PASSWORD` set to the password for the new user

**Note:** If the env var `MYSQL_DATABASE` is provided, then this new user will be given all grants to that database.

#### Delete
To delete a user, 2 env vars need to be set
1. `ACTION_USER` set to `delete`
2. `MYSQL_USER` set to the name of the new user