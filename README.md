# creative-coding

## video link
https://www.youtube.com/watch?v=RPx1WmuFHhw&t=27s&ab_channel=Yes


## 1. I FEEL DIZZY (Recursive-Thoughts) 
- Technique : recursive algorithm
- Description : This process is inspired by Casey Reas' work and aims to represent the feeling of dizziness and mental complexity. It combines a fractal tree visualization with the text "I FEEL DIZZY" to illustrate the idea that excessive thinking can lead to mental overload.

<img width="554" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/d54b5383-6583-438e-9830-44430ff50852">
<img width="563" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/da0fea99-096b-4904-9c28-19136039f143">
<img width="565" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/4f3ef988-ab1f-477d-8055-840e00d3329a">
<img width="582" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/72e26424-6c6a-4994-bca4-47a25cd93674">

## 2. Draw your night sky
- Technique  : L-System, random하게 constellation 을 생성하기 위한, vertex의 좌표를 담은 배열 
- Description : creates a night sky with stars and constellations. The constellations are generated based on an L-system rule, and the user can interactively change the constellations by pressing keys. The shooting star effect adds an interesting visual element to the night sky.
  
 <img width="420" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/7195c5d2-14e5-4495-af2e-a5e2f65b3666">


## 3. Stack your memory! 
- Technique : webGL 
- Description : The idea was to create an image collage in 3D rather than the usual 2D format. In this 3D environment, users can interact and manipulate blocks to create their collage.
The thought of how to better preserve precious memories through photographs led to the idea of creating 3D cubes from photos, allowing users to experiment with various shapes and angles. This feature was developed to explore ways of cherishing memories in a three-dimensional manner. 
"This project aims to let you put your favorite photos on 3D blocks and move them around. You can stack them and look at your memories from different angles. You can also change the background color to make your photos look better. We did this because we thought it would be cool to remember things in 3D, not just on a flat surface."

<img width="485" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/90dca7da-06c8-4cb8-90af-4e393bc4ac5d">
<img width="507" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/14f105c6-6d5d-42b9-b134-87ea9fc41c0b">
<img width="447" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/a5cacb9e-7e08-4ef0-bbb1-088d172d6cd6">


## 4. Steps to Afterworld 
- Technique  : generative design system - slider
Convert the image to grayscale and detect edges 
Copy the pixel array values of the grayscale-converted image to the screen's pixel array 
- Description : Repetition along the Vertical axis: Stepping out from the end of the Corridor(death) and Entering the Afterlife / Repetition along the Horizontal axis: Separation of the Spirit from the Physical body
  
![이미지 2023  12  7  오후 8 51](https://github.com/jinnyleeis/creative-coding/assets/101055312/c2870d74-1377-4cdd-9d79-cf8f6bc6746c)


## 5. big mac index of the world 
- Technique : Data visualization
- Description : The motivation behind this project is the standardized nature of the Big Mac burger, which is made with similar ingredients and follows a uniform recipe, regardless of the region it is sold in. Therefore, if the price of a Big Mac burger is higher in one country compared to others, it suggests that the cost of living in that country is relatively higher. To visualize this concept in a simple and intuitive way, I considered using a barcode-style visualization in the project.
  
<img width="757" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/9189cd8c-d5c2-4d03-864e-282cee41f837">
<img width="686" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/ae613dad-3765-4140-9e4e-4b23fb3d6621">


## 6. things once created, once perished 
- Technique : particle system 
- Description : I implemented the creation of existence through particles, where each pixel is represented as a particle. 
The particles accumulate vertically, creating a stacking effect. When the mouse is hovered over, particles emit smoke, simulating the dissolution of existence as the particles disappear.

<img width="568" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/464feaf5-3291-4c9b-82ed-543267eb32c8">
<img width="318" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/58d721fc-f936-487b-9d6f-4752e8f94306">



## 7. Would you like me to tell you how Mom and Dad first met?
- Technique : Machine-learning - classification
- Description : This project visualizes the story of how Mom and Dad met by reminiscing about the past, narrated to a child using Processing. Inspired by the interactive newspapers in the Harry Potter series, the goal was to create a dynamic recollection scene where specific parameters trigger animated changes.
  
<img width="824" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/1b2b105e-0ff3-41a0-8f50-6eda4e9c6cf5">

  
## 8. “Your Phone: The Cocktail Maker" 
- Technique : Machine-learning - Dynamic Time wrapping, motion sensing
- Description : I thought that if the gesture recognition is not just acting as a controller
but if the phone itself becomes an object for direct interaction, the gestures would have more meaningful interactions. Therefore, I made the phone itself correspond to the cocktail.

<img width="1112" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/d2ce6a41-56d2-4abe-8322-0b52555a0dae">
<img width="1141" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/cbaf166b-9ebd-49f1-afd8-016606417d8f">



## 9. “Chord of the Minions “ 
-  Technique :  Machine-learning - Polynomial Regression
- Description : To create an instrument, I recorded the sounds of Minions for each pitch from C4 to F5, ensuring that each of the 11 pitches corresponded to a specific recorded sound. When a key on the keyboard is pressed, it triggers the playback of the corresponding pitch. 
The input for the model is the continuous value of the microphone's position, and the output is the volume values of the two Minions. In other words, as the microphone moves to the right, it distances itself from the first Minion, resulting in only the sound of the second Minion being prominent. Conversely, when the microphone moves to the left, only the sound of the first Minion is clearly audible. If the microphone is positioned in the middle of the two Minions, it creates a harmonized effect as both sounds blend together.

<img width="808" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/dba67765-8edb-4e22-accf-39a195d83734">


##10.Celesture
- Technique : Machine-learning - classification
- Description: You can create the texture through gestures such as turning,lifting, and stirring your phone.
  
<img width="1024" alt="image" src="https://github.com/jinnyleeis/creative-coding/assets/101055312/1f14a6f2-2307-4646-9047-6cf598e8693e">
