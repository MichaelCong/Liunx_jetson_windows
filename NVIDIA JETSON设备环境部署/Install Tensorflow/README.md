# JetsonTX2ForDeeplearning
Setting up Jetson TX2 with OpenCV Tensorflow &amp; Keras for deep learning. I have tried a lot of online tutorials about setting up Jetson TX2. However, not all of them works. The reason is due to some of them are outdated and the libraries provided by Nvidia got upgraded. This is what I found at least working for now.

Note: If there is any library update and for some reason, any of them is not working, let me know and I will try to update the code.

```

## Tensorflow Install

I highly recommend to install prebuild binary. As suggested from https://github.com/JasonAtNvidia/JetsonTFBuild

Otherwise, please follow the link to compile and install tensorflow.

Note: place make sure the versions of dependencies meet the requirement, otherwise, you will see errors like not being able to find a particular library.

```
./install_tensorflow.sh
```

## Keras Install

```
./install_keras.sh
```
