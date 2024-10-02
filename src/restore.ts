import { exec } from "child_process";
import path from "path";

// Define the path to the shell script
const scriptPath = path.join(__dirname, "scripts", "restore_database.sh");

// Utility function to execute a shell command
const executeCommand = (command: string): Promise<string> => {
  return new Promise((resolve, reject) => {
    exec(command, (error, stdout, stderr) => {
      if (error) {
        reject(`Error executing command: ${error.message}`);
      }
      if (stderr) {
        console.warn(`Warning: ${stderr}`);
      }
      resolve(stdout);
    });
  });
};

// Main function to handle database restoration
const restoreDatabase = async () => {
  try {
    // Ensure the script is executable
    await executeCommand(`chmod +x ${scriptPath}`);

    // Execute the restore script
    const output = await executeCommand(`bash ${scriptPath}`);
    console.log(output);
  } catch (error) {
    console.error(error);
  }
};

// Run the restore process
restoreDatabase();
