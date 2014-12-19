import java.io.*;

import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioSnippet finish,tstart;
boolean finF = false;
AudioSnippet onemin,thirty,fivemin;
boolean oneminF = false,thirtyF = false,fiveminF = false;
AudioSnippet[] sec = new AudioSnippet[10];
boolean[] secF = new boolean[10];

ArrayList backs;
PImage back;
int backF = 0;

int PreferTime = 600;
int count,timeCount,becount;
boolean startFlag = false,stopFlag = false,rf = false;

void setup(){
  frame.setTitle("プロ生ちゃんタイマー");
  PGraphics icon = createGraphics(64,64,JAVA2D);
  icon.image(loadImage("icon_64.png"),0,0);
  frame.setIconImage(icon.image);
  size(500,200);
  frameRate(60);
  minim = new Minim(this);
  finish = minim.loadSnippet("./voices/finish.mp3");
  tstart = minim.loadSnippet("./voices/start.mp3");
  onemin = minim.loadSnippet("./voices/1min.mp3");
  thirty = minim.loadSnippet("./voices/30sec.mp3");
  fivemin = minim.loadSnippet("./voices/5min.mp3");
  for(int i = 1;i <= 10;i++){
    sec[i - 1] = minim.loadSnippet("./voices/" + str(i) + ".mp3");
  }
  File datas = new File(sketchPath + "/backs/");
  String[] files = datas.list();
  // println(files);
  backs = new ArrayList();
  for(int i = 0;i < files.length;i++){
    backs.add(loadImage("./backs/pronama" + str(i + 1) + ".jpg"));
  }
  count = PreferTime;
  becount = count;
  timeCount = 0;
  frame.setAlwaysOnTop(true);
}

void draw(){
  if(timeCount % 60 == 0 && startFlag == true && stopFlag == false && count > 0){
    becount = count;
    count--;
    if(count == 0){
      stopFlag = true;
    }
  }else if(startFlag == false){
    becount = 0;
    count = PreferTime;
    timeCount = 0;
  }
  // background(255);
  // image(back,0,0,back.width,back.height);
  back = (PImage)backs.get(backF % backs.size());
  image(back,0,0,width,width * back.height / back.width);
  textSize(16);
  boolean start = button("Start",width / 3 - 50,130,100,23);
  boolean stop = button("Stop",width / 3 * 2 - 50,130,100,23);
  boolean reset = button("Reset",width / 3 - 50,160,100,23);
  boolean quit = button("Change",width / 3 * 2 - 50,160,100,23);
  textSize(72);
  fill(255);
  String timenow = nf(count / 60,2) + ":" + nf(count % 60,2);
  text(timenow,width / 2 - textWidth(timenow) / 2 + 2,92);
  text(timenow,width / 2 - textWidth(timenow) / 2 + 2,88);
  text(timenow,width / 2 - textWidth(timenow) / 2 - 2,88);
  text(timenow,width / 2 - textWidth(timenow) / 2 - 2,92);
  fill(0);
  text(timenow,width / 2 - textWidth(timenow) / 2,90);
  textSize(18);
  boolean tenmu = button("▲",width / 4 + 25,5,40,25);
  boolean onemu = button("▲",width / 4 + 70,5,40,25);
  boolean tensu = button("▲",width / 4 + 140,5,40,25);
  boolean onesu = button("▲",width / 4 + 185,5,40,25);
  boolean tenmd = button("▼",width / 4 + 25,95,40,25);
  boolean onemd = button("▼",width / 4 + 70,95,40,25);
  boolean tensd = button("▼",width / 4 + 140,95,40,25);
  boolean onesd = button("▼",width / 4 + 185,95,40,25);
  if(start){
    if(startFlag == false || stopFlag == true){
      tstart.rewind();
      tstart.play();
    }
    startFlag = true;
    stopFlag = false;
  }
  if(stop){
    startFlag = true;
    stopFlag = true;
  }
  if(reset){
    startFlag = false;
    stopFlag = false;
  }
  if(quit){
    /*
    onemin.close();
    thirty.close();
    for(int i = 1;i <= 10;i++){
      sec[i - 1].close();
    }
    finish.close();
    minim.stop();
    super.stop();
    exit();
    */
    backF++;
  }
  if(startFlag == false || stopFlag == true){
    if(tenmu){
      if(timeJudge(PreferTime,600,'+') && timeJudge(count,600,'+')){
        if(stopFlag == false){
          PreferTime += 600;
        }else{
          count += 600;
        }
      }
    }
    if(onemu){
      if(timeJudge(PreferTime,60,'+') && timeJudge(count,60,'+')){
        if(stopFlag == false){
          PreferTime += 60;
        }else{
          count += 60;
        }
      }
    }
    if(tensu){
      if(timeJudge(PreferTime,10,'+') && timeJudge(count,10,'+')){
        if(stopFlag == false){
          PreferTime += 10;
        }else{
          count += 10;
        }
      }
    }
    if(onesu){
      if(timeJudge(PreferTime,1,'+') && timeJudge(count,1,'+')){
        if(stopFlag == false){
          PreferTime += 1;
        }else{
          count += 1;
        }
      }
    }
    if(tenmd){
      if(timeJudge(PreferTime,600,'-') && timeJudge(count,600,'-')){
        if(stopFlag == false){
          PreferTime -= 600;
        }else{
          count -= 600;
        }
      }
    }
    if(onemd){
      if(timeJudge(PreferTime,60,'-') && timeJudge(count,60,'-')){
        if(stopFlag == false){
          PreferTime -= 60;
        }else{
          count -= 60;
        }
      }
    }
    if(tensd){
      if(timeJudge(PreferTime,10,'-') && timeJudge(count,10,'-')){
        if(stopFlag == false){
          PreferTime -= 10;
        }else{
          count -= 10;
        }
      }
    }
    if(onesd){
      if(timeJudge(PreferTime,1,'*') && timeJudge(count,1,'*')){
        if(stopFlag == false){
          PreferTime -= 1;
        }else{
          count -= 1;
        }
      }
    }
  }
  // 以降音声
  for(int i = 1;i <= 10;i++){
    if(count == i && becount == i + 1){
      if(secF[i - 1] == false){
        sec[i - 1].rewind();
        sec[i - 1].play();
        secF[i - 1] = true;
      }
    }else{
      secF[i - 1] = false;
    }
  }
  if(count == 0 && becount == 1){
    if(finF == false){
      finish.rewind();
      finish.play();
      finF = true;
    }
  }else{
    finF = false;
  }
  if(count == 300 && becount == 301){
    if(fiveminF == false){
      fivemin.rewind();
      fivemin.play();
      fiveminF = true;
    }
  }else{
    fiveminF = false;
  }
  if(count == 60 && becount == 61){
    if(oneminF == false){
      onemin.rewind();
      onemin.play();
      oneminF = true;
    }
  }else{
    oneminF = false;
  }
  if(count == 30 && becount == 31){
    if(thirtyF == false){
      thirty.rewind();
      thirty.play();
      thirtyF = true;
    }
  }else{
    thirtyF = false;
  }
  // ここまで音声
  rf = false;
  if(startFlag == true && stopFlag == false){
    timeCount++;
  }
}

boolean timeJudge(int time,int diff,char calc){
  if(calc == '+'){
    if(5999 < time + diff || time + diff < 0)
      return false;
    else
      return true;
  }else{
    if(time - diff < 0 || 5999 < time - diff)
      return false;
    else
      return true;
  }
}

void mouseReleased(){
  rf = true;
}

boolean button(String str,float buttonX,float buttonY,float wide,float high){
  strokeWeight(1);
  stroke(0);
  fill(255,200);
  rect(buttonX,buttonY,wide,high);
  fill(0);
  text(str,buttonX + wide / 2 - textWidth(str) / 2,buttonY + high / 2 + textAscent() / 2 - 2);
  if(rf && buttonX < mouseX && mouseX < buttonX + wide && buttonY < mouseY && mouseY < buttonY + high)
    return true;
  else
    return false;
}

