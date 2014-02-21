function RandomBackground (num) {
  var url = "http://unkeltao.qiniudn.com/bgimg/IMG_"+parseInt(num*Math.random())+"_fengmian.jpg";
  var cssString = "html{background: url('"+url+"') no-repeat center center fixed;-webkit-background-size: cover;-moz-background-size: cover;-o-background-size: cover;background-size: cover;}";
  var doc=document;
  var style=doc.createElement("style");
  style.setAttribute("type", "text/css");

  if(style.styleSheet){// IE
    style.styleSheet.cssText = cssString;
  } else {// w3c
    var cssText = doc.createTextNode(cssString);
    style.appendChild(cssText);
  }

  var heads = doc.getElementsByTagName("html");
  if(heads.length)
    heads[0].appendChild(style);
  else
    doc.documentElement.appendChild(style);
}