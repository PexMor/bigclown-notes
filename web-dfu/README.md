# Web DFU experiment

[Git:bch-firmware-utility](https://github.com/bigclownlabs/bch-firmware-utility)

Take the **bch-firmware-utility-patch** directory content and update
**bch-firmware-utility** files acordingly.

Run ```script/bootstrap``` from **bch-firmware-utility**, this will prepare the environment.

Next step is to run the ``bcf/rest.py``, that stars the REST webserver on port 8080 (if you have some web server on that port please update as necessary).

Then take the contents of **web** and put it on your local or any other server. Then point yor web browser to the test.html.

**Or**

You can even just open it in a browser as file.

And voila:

When clicked **Enumerate Clowns** shall show something like ``["dfu:7FB4A2AABBCC"]`` which is the list of one element of my Core modules connected to the computer.

