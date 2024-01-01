let cube;
let images = [];
let blockCount = 0;
let isDragging = false;
let selectedBlock = null;

let font;
let bgColor = 200; // 초기 배경색
let textColor = 0; // 초기 텍스트 색상 (검정색)

function preload() {
  for (let i = 1; i <= 5; i++) {
    images.push(loadImage(`image${i}.jpg`)); // 이미지 파일 경로 수정
  }
  font = loadFont("cmmi10.ttf");
}

function setup() {
  createCanvas(800, 600, WEBGL);
  cube = new Cube(300);
  cube.texture(images);
}

function draw() {
  background(bgColor); // 배경색 조절

  textFont(font);
  textSize(100);
  fill(textColor); // 텍스트 색상 조절
  text("Stack Your Memories", 0, 600, 1200, 200);

  orbitControl();

  cube.show();

  if (isDragging && selectedBlock) {
    let mx = mouseX - width / 2;
    let my = mouseY - height / 2;
    selectedBlock.updatePosition(mx, my);
  }
}

function mousePressed() {
  if (!selectedBlock) {
    for (let block of cube.blocks) {
      if (block.contains(mouseX - width / 2, mouseY - height / 2)) {
        selectedBlock = block;
        isDragging = true;
        break;
      }
    }
  }
}

function mouseReleased() {
  isDragging = false;
  selectedBlock = null;
}

function keyPressed() {
  if (key === 'a') {
    // 'a' 키를 누르면 배경색 및 텍스트 색상을 더 밝게
    bgColor -= 10;
    bgColor = constrain(bgColor, 0, 255);
    textColor += 10;
    textColor = constrain(textColor, 0, 255);
  } else if (key === 'b') {
    // 'b' 키를 누르면 배경색 및 텍스트 색상을 더 어둡게
    bgColor += 10;
    bgColor = constrain(bgColor, 0, 255);
    textColor -= 10;
    textColor = constrain(textColor, 0, 255);
  }
}

class Cube {
  constructor(size) {
    this.size = size;
    this.blocks = [];
  }

  texture(images) {
    // 각 면에 이미지 매핑
    this.blocks.push(new Block(this.size, 0, 0, this.size, images[0], 0));
    this.blocks.push(new Block(-this.size, 0, 0, this.size, images[1], PI));
    this.blocks.push(new Block(0, this.size, 0, this.size, images[2], -PI / 2));
    this.blocks.push(new Block(0, -this.size, 0, this.size, images[3], PI / 2));
    this.blocks.push(new Block(0, 0, this.size, this.size, images[4], -PI / 2));
  }

  show() {
    for (let block of this.blocks) {
      block.show();
    }
  }
}

class Block {
  constructor(x, y, z, s, tex, rotation) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.size = s;
    this.texture = tex;
    this.rotation = rotation;
  }

  show() {
    push();
    translate(this.x, this.y, this.z);
    rotateZ(this.rotation);
    texture(this.texture);
    box(this.size);
    pop();
  }

  contains(px, py) {
    let halfSize = this.size / 2;
    return (
      px > this.x - halfSize &&
      px < this.x + halfSize &&
      py > this.y - halfSize &&
      py < this.y + halfSize
    );
  }

  updatePosition(mx, my) {
    this.x = mx;
    this.y = my;
  }
}
