# Add a new language

To add a new language, edit the `tools/find_language.sh` file, add your language at the end.

Each new language should have a folder of the same name in `images/`, this folder should contain a `Dockerfile.base` and a `Dockerfile.standalone`.

The `Dockerfile.base` will be used by the user to build his own images with his dockerfile, and should be buildable by itself without project details.

The `Dockerfile.standalone` should be copyable directly at the root of the user repository and able to build accordingly.

For your new language to be available as a base image, you will need to uninstall Whanos while clearing all existing data! See Uninstall (section Remove everything), do the steps, and then see Install.

However, you should be able to use the standalone images of your language right away by redeploying using ansible! See Install.