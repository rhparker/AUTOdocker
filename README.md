# AUTOdocker

This repository contains everything necessary to get the parameter continuation software AUTO to run inside a Docker container. 

[AUTO](https://github.com/auto-07p/auto-07p) is a publicly available software package used for continuation and bifurcation problems in ordinary differential equations and dynamical systems.

[Docker](https://www.docker.com) is a platform that delivers OS-level virtualization via packages called containers. Containers can run on any system which supports Docker, are isolated from each other and from the host system, and contain all of the software and libraries needed for an application to run.

Running AUTO in a Docker container allows the software to be run in configuration which is standard across all platforms. Furthermore, you can run AUTO this way without have it (or any of the software it requires) installed on your system! Interfacing with AUTO can be done using both the command line and Jupyter notebooks. This package contains Jupyter notebooks for most of the AUTO demos which can be used as a branch point (pun intended) for future exploration.

# Getting started

1. Install [Docker Desktop](https://www.docker.com/) on your system. There are versions for Windows and Mac, as well as for major Linux distributions. A preview version of Docker capable of running AUTO runs on the new M1 Mac.

2. Clone this git repository in a directory of your choice.   

        git clone git@github.com:rhparker/AUTOdocker.git

3. Make sure the Docker engine is running. If you installed Docker on a PC, it should be running (if it is not, or you get an error later, start Docker Desktop). If you installed Docker on a Mac, start Docker Desktop to get Docker engine running. 

4. Open a shell window (Terminal/iTerm on Mac, PowerShell on Windows). Change directories to the location of the git repository. Then run  

        docker-compose up

to start the Docker container and run a Jupyter notebook in it. 

5. Copy/paste the URL for the Jupyter notebook into your browser to start Jupyter (in Windows PowerShell, the Enter key copies what is selected; I don't know either). By default, Jupyter starts in directory where AUTO is installed. In Jupyter, change directories to the ``workspace`` directory. The  ``workspace`` directory mirrors the directory where you started Docker. Everything outside of that directory lives only inside the Docker container, and will be lost when the container is stopped.

6. Go to the ``demos`` directory. Choose one of the Jupyter notebooks and run it! These notebooks are almost identical to the standard AUTO demos; the only changes have been those needed to get them to run in a Jupyter notebook.

7. To learn more about how to use AUTO and the various demos, consult the AUTO manual, which you can find in the Docker container at ``/doc/auto.pdf``. Jupyter blocks opening the PDF, but you can download it (right click, then Save As on most browsers).

8. Data and code from the demos are stored in the temporary directory ``demo`` inside the ``demos`` directory. If you run multiple demos, remove the code and any remaining data from the previous demo before running the next one.

# Using AUTO for your own project

Copy the ``docker-compose.yml`` file to your project directory and run 

        docker-compose up

to start the Docker container and run a Jupyter notebook in it. Your project directory will be mirrored in ``/workspace`` (you can change the directory name by editing the ``docker-compose.yml`` file). If you like, you can use ``demos/demotemplate.ipynb`` from the original git repository as a bare-bones template, or you can start with one of the demos.

# Running AUTO from the command line

In a shell window, change to the directory you wish to use for your AUTO project. Make sure Docker engine is running. On Windows PowerShell, type

        docker run -it -v ${PWD}:/auto/workspace --entrypoint /bin/bash rhparker/auto

On Mac or UNIX systems, type

        docker run -it -v $PWD:/auto/workspace --entrypoint /bin/bash rhparker/auto

This gives you shell access to the Docker container, with the AUTO working directory as the home directory. The directory where you started Docker is mirrored as ``workspace``, which you can always get to using ``cd ~/workspace``. You can start the AUTO interactive console by running ``auto``. The AUTO python libraries can be easily imported, e.g.

        from auto import AUTOCommands as ac

The AUTO interactive plotter does not at present work when using the command line interface. Plotting can easily be done using Jupyter notebooks.

# Plotting

The Jupyter notebook interface supports the AUTO ``plot`` function, but not the interactive plotter. For examples of this in action, see the individual AUTO demos. Implemeting the ``plot`` function in a platform-independent way uses a workaround which reroutes the X11 display to the virtual framebuffer ``Xvfb`` by means of the [``pyvirtualdisplay``](https://pypi.org/project/PyVirtualDisplay/) Python package. The ``plot`` function saves its output to a PNG image, which is then displayed in the Jupyter notebook.

As an alternative, you can use ``matplotlib`` directly to plot the output from AUTO. See the demos ``ab-mpl.ipynb`` and ``cusp-mpl.ipynb`` for simple examples of this.

# Demos

Most of the demos from the AUTO distribution have been converted into Jupyter notebooks, with the exception of the miscellaneous demos and the HomCont demos. These demos are identical to the ones in the AUTO package, with the only changes being what is needed to get them to run in a Jupyter notebook. Each demo contain example plots of relevant output (bifurcation diagrams, solutions, both). When plotting instructions are given or plots are shown in the AUTO manual, those plots are reproduced in Jupyter. You can also look at the Jupyter notebooks for individual demos (including the plots) directly on Github.

# Dockerfile

By default, this uses the Docker image ``rhparker/auto`` from [dockerhub](https://hub.docker.com/). The Dockerfile used to build this image is in the git repository.

# Troubleshooting

If on occasion the Docker container does not start, try running

        docker container prune

to remove Docker containers that are no longer active but did not complete shut down.







