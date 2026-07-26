import os
files=0
for r,d,f in os.walk("."):
    if len(r)>2:
        if r[2]!=".":
            for fi in f:
                if not fi.endswith(".import"):
                    if not fi.endswith(".uid"):
                        if not fi.endswith(".tmp"):
                            if not fi.endswith(".cache"):
                                print(r,fi)
                                files+=1
    #for fi in f:
    #    files+=1
        #print(fi)
print(files)