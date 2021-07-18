# Minecraft-building-turtle

## What is it

A minecraft turtle script able to build constructions using a .txt file with the coordinates of each cube to place.
It includes the parser to read the file, and the logic to sort the instructions in order for the turtle to choose short paths.

## How to use

* Go to https://drububu.com/miscellaneous/voxelizer/?out=obj or use any other website or software allowing you to convert a 3D model into a voxel model, and save it as a list of voxel coordinates (choose .txt file format on voxelizer). Voxelizer tells you how many cubes the model is made of, and thus how many your turtle will need. An example file is provided (torus.txt).
* Rename the model file "model.txt".
* Download the builder.lua script and your model.txt on your turtle, at the same level in the hierarchy.
* Place your turtle below a chest containing the materials it will need if it goes out of material. It will save the location into memory.
* Launch the program.

Don't forget to provide the turtle enough material (any placable cube) and fuel for it to run. It will search for fuel at startup and after each layer of material placed in its whole inventory. In case of lack of fuel it will sleep until refilled. In case of lack of material, it will go back to it's spawning position and try to get material from the chest below it. Also provide it a large enough and unobstructed space for it to build your model.
Also be aware that going too far from the turtle, or disconnecting from a local world, will cause it to be unloaded and promptly stop it's labor. You might want a world anchor in the case of a live server. In the case of a local world, well you can't quit the game until it has finished.

## To do

Optimize path for big hollow objects.
