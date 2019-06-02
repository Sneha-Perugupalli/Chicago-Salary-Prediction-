//////////////////////////////////// 
//Java Script for animated output//
//////////////////////////////////

var canvas, ctx;
var barWidth;
var linesToDraw;
var id;
var textBuffer = 20;
var block = 30;
var margin = 20;
var colors = ['#900','#090','#009','#990','#099','#FF0000','#000000','#7FFF00','#FF8C00','#Dc143C'];
var data = [
  [232,'Stroger Hospital'],
  [178,'Health'],
  [163,'Provident Hos'],
  [26,'Justice adv'],
  [181,'Ambulatory com'],
  [54,'Human Res'],
  [155,'Transpotation'],
  [80,'Admin'],
  [105,'BOH'],
  [18,'OAK Forest']
  
  ];

function init() {
  var x = document.getElementById("myDIV");
    if (x.style.display === "none") {
        x.style.display = "block";
    } else {
        x.style.display = "none";
    }
  canvas = document.getElementById('histogram');
  ctx = canvas.getContext('2d');
  barWidth = (canvas.width / data.length) - margin;
  
  drawHistogram();
}

function drawHistogram() {
  cancelAnimationFrame(id);
  ctx.clearRect(0,0, canvas.width, canvas.height);
  drawAxisLabels();
  linesToDraw = block * 12;
  
  id = requestAnimationFrame(drawBars);
}
function drawBars() {
  ctx.save();
  
  ctx.translate(20, canvas.height-20);
  
  for (var j=0; j<data.length; j++) {
    var currentLine = 360 - linesToDraw;
    ctx.fillStyle = colors[j];
    if (block*(data[j][0]/20) >= currentLine)
      ctx.fillRect(barWidth*j + margin*j,0,barWidth,-currentLine);
  }
  
  linesToDraw--;
  
  if (linesToDraw > 0) {
    id = requestAnimationFrame(drawBars);
  }
  
  ctx.restore();
}

function drawAxisLabels() {
  ctx.save();
  
  ctx.translate(20, canvas.height-20);
  
  for (var i=0; i<data.length; i++) {
    ctx.fillStyle = colors[i];
    ctx.fillText(data[i][1], barWidth*i + margin*i + 5, 15);
  }
 var k  = [0,20,40,60,80,100,120,140,160,180,200,220,240];
  for (var j=0;  j<=12; j++) {
    ctx.fillStyle = 'black';
    ctx.fillText(k[j], -textBuffer, -j * block);
    
  }
  
  ctx.restore();
}


