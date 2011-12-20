=============================================
Technical Communication's Documentation Build
=============================================
:author: Josh Johnson <jjohnson@webassign.net>
:ref: https://staff.webassign.net/wiki/index.php/CI_Build/Technical_Communications_Unassisted_Build
:ref: http://dita-ot.sourceforge.net/
:ref: http://ant.apache.org/
:ref: http://xmlgraphics.apache.org/fop/
:ref: http://www.oxygenxml.com/

.. note::
   **WARNING:** We have not migrated TechComm to using the git server yet. This build is configured to use a locally-hosted repository to check out the source. Set the `SOURCE_REPO` variable in `bootstrap.sh` before proceeding.
    
.. note::
   **WARNING:** This build does not work with the current source. Please apply `source_changes.patch` to your source before proceeding.

.. contents::
   
Quick Start
===========
To prepare for the build, simply run `bootstrap.sh` in this directory.

This will download all necessary files, unpack them, and do some basic setup.

Then all you have to do is run `build.sh` from this directory, and the build will proceed.

Look for output files in `out`:
  - Student guide is in `out/m_s_student_guide.pdf`
  - Instructor guide is in `out/m_i_student_gude.pdf`
  - Creating Questions is in `out/m_i_creating_questions_guide.pdf`
  - Instructor WebHelp is in `out/instructor_guide/index.html`
  - Student WebHelp is in `out/student_guide/index.html`
  
The log file is `build.log` by default. Look there if there are any problems.

.. note::
   The current version of `bootstrap.sh` assumes you have `curl` and `java` already installed in your system, along with `unzip` and `tar`.
  
Working With `build.sh`
=======================
`build.sh` will pass any parameters along to Ant as-is. You can specify what specific
target you want to build, or add additonal run-time parameters.

Available Targets
-----------------
:instructor_guide: "WebAssign Instructor Guide" - PDF
:student_guide: "WebAssign Student Guide" - PDF
:creating_questions: "WebAssign Creating Questions Guide" - PDF
:instructor_webhelp: "WebAssign Instructor Help System" - HTML Help
:student_webhelp: "WebAssign Student Help System" - HTML Help

Useful Ant Properties
---------------------
You can also pass properties via the command line to override any that are used within the build scripts.

They are specified with the `-D` flag.

Here's a short list of properties you may want to override (but most likely won't). See http://dita-ot.sourceforge.net/1.5.3/quickstartguide/reference/dita-ot_ant_properties.html and the XML files in this directory for a full list.

:local.build.log: Path to the file to log to (will be overridden with each build)
:args.debug: yes/no, provides more output to the log for debugging
:clean.temp: yes/no, delete temporary files (default is yes)
:clean.output: yes/no, delete the output files before building (default is yes)
:output.dir: path to the output directory (be careful here; this is set differently in the build for PDFs and each WebHelp output)
:oxygen.dir: path to an unzipped distribution of Oxygen
:dita.dir: path to DITA-OT files


Usage Examples
--------------

Just Generate One Target
~~~~~~~~~~~~~~~~~~~~~~~~
This is accomplished by just passing one of the targets mentioned above as a command-line argument to `build.sh`::
    
    $ ./build.sh instructor_guide
    
This will just build the "WebAssign Instructor Guide" PDF.

Log To A Different File (Pass Ant Properties)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Properties are passed using the `-D` flag. I've always seen it in quotes; not sure if that is strictly necessary.

::
    
    $ ./build.sh "-Dlocal.build.log=../mylog.log"
    
.. note::
   The paths are relative to the `dita_source_files` directory.
   
File Layout
===========
All scripts and the general build mechanism run out of this directory. 

In this directory:

+---------------------+-------------------------+------------------------------------+
|File                 | Purpose                 | Notes                              |
+=====================+=========================+====================================+
|.gitignore           | Prevents git from       |                                    |
|                     | seeing various files    |                                    |
|                     | as part of the code     |                                    |
|                     | base                    |                                    |
+---------------------+-------------------------+------------------------------------+
|bootstrap.sh         | Downloads and configures| Doesn't install java               |
|                     | all tools and packages  | curl, unzip or tar                 |
+---------------------+-------------------------+------------------------------------+
|build.log            | The default build log   |                                    |
+---------------------+-------------------------+------------------------------------+
|build.sh             | Build script            | Assumes java is in                 |
|                     |                         | your $PATH                         |
+---------------------+-------------------------+------------------------------------+
|build.xml            | Core build configuration| Uses Apache Ant.                   |
|                     |                         |                                    |
|                     |                         | Calls the other build scripts,     |
|                     |                         | sets common settings               |
+---------------------+-------------------------+------------------------------------+
|build_pdf.xml        | Build config for PDFs   | Not sure if this will work alone.  |                                               
+---------------------+-------------------------+------------------------------------+
|build_webhelp.xml    | Build config for web    | Not sure if this will work alone.  |
|                     | help                    |                                    |                                              
+---------------------+-------------------------+------------------------------------+
|fop.xconf            | Configuration file for  | Necessary to get PDFs to generate  |
|                     | FOP                     | properly with relative font paths  |
+---------------------+-------------------------+------------------------------------+
|README.rst           | This file. Documentation| Written in reStructuredText.       |
+---------------------+-------------------------+------------------------------------+
|README.html          | This file, transformed  | Converted with stock docutils      |
|                     | into HTML               |                                    |
+---------------------+-------------------------+------------------------------------+
|source_changes.patch | Patch file containing   | Only temporary until TechComm      |
|                     | changes I made to get   | switches over to the git repository|
|                     | the source to build.    | on wart.                           |
+---------------------+-------------------------+------------------------------------+


./.git
------
If this build was checked out of git, this is the 'attic' directory. Hooks go here.

./deps
------
All dependant tools and java libraries are expanded here.

./dita_source_files
-------------------
This is where the Technical Communications' soure files are checked out. 

TODO
~~~~
Explain the file structure within the code base.

./downloads
-----------
All of the tarballs for all of the dependancies are downloaded to this directory.

./logs
------
This is generated by the build. Not sure what it really does. The files inside look more like intermediate products of the process than they look like logs.

TODO
~~~~
Put all logs in this directory, or get the build to put it somewhere else.

./out
~~~~~
Generated by the build. This is where all of the generated documentation is stored.

./temp
~~~~~~
Generated by the build. Stores intermediate files. DITA-OT does a lot with multiple passes of XSLT transformations. This directory is cleaned out after each build. 

To change that, either alter the property in `build.xml` or pass  `"-Dclean.temp=no"` as an argument to `build.sh`.
