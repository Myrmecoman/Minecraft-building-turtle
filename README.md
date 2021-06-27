# Minecraft-building-turtle

## What is it

A minecraft turtle script able to build constructions using a .txt file with the coordinates of each cube to place.
It includes the parser to read the file, and the logic to sort the instructions in order for the turtle to choose short paths.

## How to use

* Go to https://drububu.com/miscellaneous/voxelizer/?out=obj or use any other website or software allowing you to convert a 3D model into a voxel model, and save it as a list of voxel coordinates (choose .txt file format on voxelizer). Voxelizer tells you how many cubes the model is made of, and thus how many your turtle will need. An example file is provided (torus.txt).
* Rename the model file "model.txt".
* Download the builder.lua script and your model.txt on your turtle, at the same level in the hierarchy.
* Launch builder

Don't forget to provide the turtle enough material (any placable cube) and fuel for it to run. It will search for fuel at startup and after each layer of material placed in its whole inventory. In case of lack of fuel or material, it will sleep until refilled (NOT TESTED YET). Also provide it a large enough and unobstructed space for it to build your model.
