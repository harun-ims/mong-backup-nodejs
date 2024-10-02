# MongoDB Backup and Restore Scripts

This project contains scripts for backing up and restoring a MongoDB database. The scripts utilize shell commands and environment variables to configure the MongoDB connection details and backup settings.

## Prerequisites

Before running the scripts, ensure you have the following installed:

- [Node.js](https://nodejs.org/) (version 12 or higher)
- [MongoDB](https://www.mongodb.com/) (running and accessible)
- [MongoDB Tools](https://www.mongodb.com/try/download/database-tools) (for `mongodump` and `mongorestore` commands)
- [bash](https://www.gnu.org/software/bash/) (for executing shell scripts)

## Installation

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/harun-ims/mong-backup-nodejs.git
   cd mong-backup-nodejs
   ```

2. Copy the .env.example file and create file named .env.dev

   ```bash
    MONGO_URI=mongodb://localhost:27017
    DB_NAME=database_2
   ```

3. Install dependencies

   ```bash
    yarn
   ```

4. Backup Database for development

   ```bash
   yarn backup:dev
   ```

5. Restore Database for development
   ```bash
   yarn restore:dev
   ```

## Notes

- Make sure that your MongoDB server is running when you execute these scripts.

- The backup and restore operations can take some time, depending on the size of your database.

- Adjust the MONGO_URI and DB_NAME in the .env file as needed for different environments (e.g., development, testing, production).
