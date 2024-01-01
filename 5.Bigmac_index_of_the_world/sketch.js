var table;
var bigmacs = [];
var font;
var indexSlider;

function preload() {
  table = loadTable("bigmacindex2023.csv", "csv", "header");
  font = loadFont("AustinCyr-Roman.ttf");
}

function setup() {
  createCanvas(900, 600);
  background(0);
  var rows = table.getRows();
  var numLines = rows.length;
  var usedXPositions = [];

  for (var r = 0; r < numLines; r++) {
    var country = rows[r].getString("Country");
    var index = rows[r].getNum("Index");

    var x;

    do {
      x = random(150, width - 150);
    } while (usedXPositions.includes(x));

    usedXPositions.push(x);
    var this_case = new bigmac(country, index, x);
    bigmacs.push(this_case);
  }

  // 슬라이더 생성
  indexSlider = createSlider(0, 8, 0, 0.01); // 슬라이더 범위는 0에서 8, 초기값 0

  // 슬라이더 위치 설정
  indexSlider.position(150, height - 30);
  indexSlider.style('width', '600px'); // 슬라이더 길이 설정

  indexSlider.input(updateDisplay); // 슬라이더 값 변경 이벤트 핸들러
  // 슬라이더 스타일 설정


}

function draw() {
  background(0);
  for (var i = 0; i < bigmacs.length; i++) {
    bigmacs[i].drawcase();
  }
  
   textSize(45);
  fill(255, 255, 255);
  textFont(font);
  text("Current Big Mac Index of the world", width / 2 - 10, 100);
  
  
   textFont(font);
  text("Move the slider to discover the Big Mac Index for each country", width / 2 - 10, 100);
}

function updateDisplay() {
  var sliderValue = indexSlider.value();

  for (var i = 0; i < bigmacs.length; i++) {
    if (bigmacs[i].index > sliderValue) {
      bigmacs[i].isVisible = false;
    } else {
      bigmacs[i].isVisible = true;
    }
  }
}

var bigmac = function (country, index, x) {
  this.country = country;
  this.index = index;
  this.x = x;
  this.isVisible = true;

  this.drawcase = function () {
    if (this.isVisible) {
      this.color = map(this.index, 0, 8, 0, 200);
      this.weight = map(this.index, 0, 8, 0, 3);
      strokeWeight(this.weight);
      stroke(this.color);
      line(this.x, 150, this.x, height - 180);

      var yPos = height - 150;

      for (var i = 0; i < this.country.length; i++) {
        textSize(7);
        noStroke();
        fill(255);
        textAlign(CENTER);
        text(this.country[i], this.x, yPos);
        yPos += 5;
      }
    }
  }
}
