# Xdebug setup

## PhpStorm

If you are developing the project using PhpStorm, you can configure your IDE in order to make use of the `XDebug` debugger. The steps to enable it are the following:

1. Check if your `.env` file had the value `true` set for the variable `ENABLE_XDEBUG_SUPPORT`. If not, update the value and rebuild the container with the command `make`.

2. Open PHPStorm and head to the settings
	- Head to `Preferences | Languages & Frameworks | PHP` and click on the button `...` in order to configure a new interpreter.

	- Click on the `+` button choosing `From Docker, Vagrant, VM, etc`.

	- Choose `Docker Compose` from the radio button choices.

	- Add a new server (if no one has already been configured) by clicking on `New...` in *Server* row and by choosing `Docker for Windows` (if on Windows) `Docker for Mac` (if on MacOS) `Unix socket` (if on Linux).

	- In the dropdown relative to "Service", choose `php`.

	- Click on `Ok` and wait for the IDE to check that everything is ok.

	- Click on `Ok` once again to head back to the main settings window.

	- On the line `Docker container`, click on the folder icon.

	- Click on `Apply` and head to the section `Preferences | Languages & Frameworks | PHP | Debug`

	- Update the `Remote port` value to `9001` (or the one you chose in the `.env` file for the `XD_REMOTE_PORT` variable) then click on `Apply` again.

	- Head to `Preferences | Languages & Frameworks | PHP | Servers` and add a new server with the `+` icon.

	- Name it as the `COMPOSE_PROJECT_NAME` variable in the `.env` file and as host, set the url of the project, then check the `Use port mappings` checkbox.

	- Under the "Project files" section, add as the `Absolute path on the server`, paste `/var/www/html/PROJECT-DIR` related to the root directory of the project.

	- Complete the procedure by clicking on `Apply` and closing the settings window.

3. the configuration is now completed and you should be able to easily debug your php code with the aid of `xDebug`.


## Visual Studio Code

If you are developing the project using VSCode, you can configure your Editor in order to make use of the `xDebug` debugger. The steps to enable it are the following:

1. Check if your `.env` file had the value `true` set for the variable `ENABLE_XDEBUG_SUPPORT`. If not, update the value and rebuild the container with the command `make`.

2. Open VSCode and head to the `Extensions` tab

3. Search the extension called `PHP Debug` and install it.

4. Head to the `Debug` section and on the top-bar click on the cog and chose `PHP` from the selector in order to add a new PHP debug configuration

5. A new `launch.json` should open with 2 preconfigured configuration objects.

6. Edit the one named "Listen for XDebug" by updating the `port` value according to your environment file configuration

7. Add a new property called `pathMappings` which type has to be Object.

8. Inside the newly created object, create a new field. The key of the field has to be the path to the project module *inside the docker container* and its value must be the full path of the project module root folder inside your host computer. The result should be similar to the following snippet:
    
    ```json
    {
      "version": "0.2.0",
      "configurations": [
        {
          "name": "Listen for XDebug",
          "type": "php",
          "request": "launch",
          "port": "<ENV XD_REMOTE_PORT VALUE>",
          "pathMappings": {
            "/var/www/html/<MODULE FOLDER>": "/PATH/TO/PROJECT/<MODULE FOLDER>"
          }
        }
      ]
    }
    ```

9. Once the config file has been saved, you should be able to easily debug your php code with the aid of `xDebug`.
