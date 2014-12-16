from distutils.core import setup



setup(name = "gnukhataserver",
    version = "1.0",
    description = "A free and open source accounting and book keeping software.",
    author = "Krishnakant Mane, Ankita Shanbhag",
    author_email = "krmane@gmail.com, ankitargs@gmail.com",
    url = "www.gnukhata.org",
    #Name the folder where your packages live:
    #(If you have other packages (dirs) or modules (py files) then
    #put them into the package directory - they will be found 
    #recursively.)
    packages = ['gnukhataserver'],
    #'package' package must contain files (see list above)
    #I called the package 'package' thus cleverly confusing the whole issue...
    #This dict maps the package name =to=> directories
    #It says, package *needs* these files.
    #package_data = {'package' : files },
    #'runner' is in the root.
    scripts = ["gkstart"],
    long_description = """GNUKhata is a foss based accounting and inventory software that helps book keeping for small scale enterprises as well as big organisations.""" 
    #
    #This next part it for the Cheese Shop, look a little down the page.
    #classifiers = []     
) 

    
