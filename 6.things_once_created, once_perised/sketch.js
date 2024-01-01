let particleSystem;
let res = 10;
let img;
let numPixelsHorizontal;
let numPixelsVertical;
let currentFrame = 0;
let texture;

function preload() {
  img = loadImage("newyork3.png");
  texture = loadImage('smoke_thin.png');
}

function setup() {
  createCanvas(800, 500);
  particleSystem = new ParticleSystem();
  particleSystem.placeParticles(img);
  noStroke();
  
  numPixelsHorizontal = width / res;
  numPixelsVertical = height / res;
}

function draw() {
  background(0);

  // 현재 프레임에 해당하는 픽셀 그룹 그리기
  let startIdx = currentFrame * numPixelsHorizontal;
  let endIdx = min((currentFrame + 1) * numPixelsHorizontal, particleSystem.sortedParticles.length);

  for (let i = 0; i < endIdx; i++) {
    let p = particleSystem.sortedParticles[i];
  //  p.update();
    p.draw();
    //  p.update();
  }

  currentFrame++;

  // 모든 픽셀이 그려졌을 경우, 애니메이션 중지
  if (currentFrame >= ceil(particleSystem.sortedParticles.length / numPixelsHorizontal)) {
    // noLoop();
  
  }
   if (mouseX >= 0 && mouseX <= width && mouseY >= 0 && mouseY <= height) {
    // Find the particle at the clicked position
    let clickedParticle = particleSystem.findParticle(mouseX, mouseY);
}
  
}

class Particle {
  constructor(x, y, c) {
    this.x = x;
    this.y = y;
    this.c = c;
    this.homeX = x;
    this.homeY = y;
    this.lifetime = 255;
  }
  
  

  update() {
    let mouseD = dist(this.x, this.y, mouseX, mouseY);
    let mouseA = atan2(this.y - mouseY, this.x - mouseX);
    let homeD = dist(this.x, this.y, this.homeX, this.homeY);
    let homeA = atan2(this.homeY - this.y, this.homeX - this.x);
    let mouseF = constrain(map(mouseD, 0, 100, 10, 0), 0, 10);
    let homeF = map(homeD, 0, 100, 0, 10);
    let vx = cos(mouseA) * mouseF;
    vx += cos(homeA) * homeF;
    let vy = sin(mouseA) * mouseF;
    vy += sin(homeA) * homeF;
    this.x += vx;
    this.y += vy;
  }

  draw() {
    let r = this.c[0];
    let g = this.c[1];
    let b = this.c[2];

    // 특정 범위에 있는지 확인
    if (r > 100 && g > 100 && b > 100) {
      fill(this.c);
      rect(this.x, this.y, res, res);
      //this.show(); // show texture
    }
  }

  show() {
    tint(255, this.lifetime);
    imageMode(CENTER);
    image(texture, this.x, this.y, res*5, res*5);
  }

  isDead() {
    return false;
  }
}

class ParticleSystem {
  constructor() {
    this.particles = [];
    this.sortedParticles = [];
  }

  addParticle(x, y, c) {
    this.particles.push(new Particle(x, y, c));
  }
  
 
  

  placeParticles(img) {
    for (let i = 0; i < width; i += res) {
      for (let j = 0; j < height; j += res) {
        let x = (i / width) * img.width;
        let y = (j / height) * img.height;
        let c = img.get(x, y);

        if (c[0] + c[1] + c[2] != 255 * 3) {
          this.addParticle(i, j, c);
        }
      }
    }
    // y 값이 큰 순서대로 정렬
    this.sortedParticles = this.particles.slice().sort((a, b) => b.y - a.y);
  }

  run() {
    // 매 프레임마다 정렬된 입자들 중 상위 일부만 그림
    for (let i = 0; i < numPixelsHorizontal; i++) {
      let p = this.sortedParticles[i];
    }
    
   
    
    
  }

  findParticle(x, y) {
    // Find the particle at the specified position
    for (let i = 0; i < this.sortedParticles.length; i++) {
      let p = this.sortedParticles[i];
      if (x >= p.x && x <= p.x + res && y >= p.y && y <= p.y + res) {
       
        p.show();
         p.c=[0,0,0];
        return p;
      }
    }
    return null; // No particle found at the specified position
  }
}
