# HW3-250a

This is the third homework for 250a. The idea was to create an hybrid instrument that takes audio input and uses that as an excitation to a resonant system.

My idea was to create a position tracker with the time of arrival of a single stroke ina piece of wood to two piezos at the edges of the wood stick. From this I mapped different positions in the wood piece to different notes in a scale. Which then excites a simple Karplus-strong algorithm.

# Video example

The following video is an example of the possibilities of this instrument

https://youtu.be/cWdkCeMEX_c

# Chuck side

In chuck two separate processes take place. First the analysis of the transients coming into the piezos and second the sound generation algorithm.

For the transient analysis, Im using a set of filter ( A one pole filter with independent attack and release times and an rms tracker). The two filters are combined in such a way that allows to define the transient as the moment in which the fast filter has a higher state than the slow filter. Then this is stream of booleans is differentiated to get only the changing values and finally it is filtered only to give the rising edges. With this Theres a more less accurate description of the position of the transients on each piezzo. This positions are then computed to come up with a difference in samples which is reported to the mapping system.

Finally the mapping system, takes this values and mapps the position to different frequencies on a diatonic scale.

On the other hand, the generator is a very simple Karplus-Strong algorithm which is excited with the piezzos themselves, Theres a tiny lag on the excitation signal (2 ms) to allow the computer to calculate the frequency before it is changed.

# The controller

The controller was simply build by attaching a couple of piezzos to a piece of wood and a couple of decouplers to avoid vibrations coming from the desk where it is placed.

