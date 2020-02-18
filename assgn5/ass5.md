### Q1.1 Show an image from the data set and 3 of its filter responses. Explain any artifacts you may notice. Also briefly describe the CIE Lab color space, and why we would like to use it. We did not cover the CIE Lab color space in class, so you will need to look it up online.

"In this project, we use the CIELab color, CIELab color space refer to three color channels, The L(lightness) channel is ranging from 0 to 100, a (green to red) and b (blue to yellow) channels are ranging from -128 to 127. This color space is more comfortable for human vision, at the same time, the color space would be broader than RGB space."(https://danielniu.wordpress.com/2018/06/07/bag-of-words/)

The color space is border so the different dimension of color vector of 1 pixel may contain more meaning.

The follow images are normalized to be visible

gaussian of L space, looks normal

![1_1_a](/home/jasoni111/Desktop/comp4901l/assgn5/1_1_a.bmp)

gaussian of a space, looks like some grid, but a apce looks like grid as well
![1_1_b](/home/jasoni111/Desktop/comp4901l/assgn5/1_1_b.bmp)

gaussian of b space, can only seen the grass which are green (blue to yellow)
![1_1_c](/home/jasoni111/Desktop/comp4901l/assgn5/1_1_c.bmp)
dx of L space

![1_1_d](/home/jasoni111/Desktop/comp4901l/assgn5/1_1_d.bmp)

### Q1.2 Show the results of your corner detector on 3 different images

500 points are shown here.

used 50 points per image for kmean

![1_2_a](/home/jasoni111/Desktop/comp4901l/assgn5/1_2_a.bmp)

![1_2_b](/home/jasoni111/Desktop/comp4901l/assgn5/1_2_b.bmp)

![1_2_c](/home/jasoni111/Desktop/comp4901l/assgn5/1_2_c.bmp)

### Q2.1 Show the word maps for 3 different images from two different classes (6 images total). Do this for each of the two dictionary types (random and Harris). Are the visual words capturing semantic meanings? Which dictionary seems to be better in your opinion? Why?

Harris:



![2_1_H_a](/home/jasoni111/Desktop/comp4901l/assgn5/2_1_H_a.bmp)

![2_1_H_b](/home/jasoni111/Desktop/comp4901l/assgn5/2_1_H_b.bmp)

![2_1_H_c](/home/jasoni111/Desktop/comp4901l/assgn5/2_1_H_c.bmp)

Random:

![2_1_R_a](/home/jasoni111/Desktop/comp4901l/assgn5/2_1_R_a.bmp)

![2_1_R_b](/home/jasoni111/Desktop/comp4901l/assgn5/2_1_R_b.bmp)

![2_1_R_c](/home/jasoni111/Desktop/comp4901l/assgn5/2_1_R_c.bmp)

The random ones seems better as a bog model as large region share the same tone, while the harris changes on corner despite if they are the same object.

### Q3.2 Comment on whole system:

1NN:

![3_2_1_H_chi2](/home/jasoni111/Desktop/comp4901l/assgn5/3_2_1_H_chi2.bmp)

![3_2_1_H_L2](/home/jasoni111/Desktop/comp4901l/assgn5/3_2_1_H_L2.bmp)

![3_2_1_R_chi2](/home/jasoni111/Desktop/comp4901l/assgn5/3_2_1_R_chi2.bmp)

![3_2_1_R_L2](/home/jasoni111/Desktop/comp4901l/assgn5/3_2_1_R_L2.bmp)

KNN:



![3_2_k_H_chi2](/home/jasoni111/Desktop/comp4901l/assgn5/3_2_k_H_chi2.bmp)

![3_2_k_H_L2](/home/jasoni111/Desktop/comp4901l/assgn5/3_2_k_H_L2.bmp)

![3_2_k_R_chi2](/home/jasoni111/Desktop/comp4901l/assgn5/3_2_k_R_chi2.bmp)

![3_2_k_R_L2](/home/jasoni111/Desktop/comp4901l/assgn5/3_2_k_R_L2.bmp)

![3_2_k_plot](/home/jasoni111/Desktop/comp4901l/assgn5/3_2_k_plot.bmp)

#### How do the performances of the two dictionaries compare? Is this surprising?

For NN:**Random chi-square>Harris chi-square>Harris euclidean>Random euclidean**

For KNN:**Harris chi-square>Random chi-square>Random euclidean>Harris euclidean**

The result is surprising as I cannot actually see the trend of different method. Harris seems to perform better overall as it uses key point

#### How about the two distance metrics? Which performed better? Why do you think this is?
  **chi-square distance** performs better in both dictionary as it account to the weight of difference.

### Are the performances of the SVMs better than nearest neighbor? Why or why not? Does one kernel work better than the other? Why?

Accuracy = 56.25% (90/160) (classification)

The performances of the SVMs does not outperform. Probably because the bottleneck is the dictionary and world map, not the classification method.

### How does Inverse Document Frequency affect the performance? Better or worse? Does this make sense?

This perform worse. This is probably because IDF is only used to reduce very frequent word like "The", but image don't have such problem.

### What did you experiment with and how did it perform. What was the accuracy?

SURF feature is used(using matlab toolbox)

The accuracy is abit lower but i think it is ok as only ~100 feature point is used for the world map

![exsurf](/home/jasoni111/Desktop/comp4901l/assgn5/exsurf.bmp)







