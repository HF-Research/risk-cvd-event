 // !preview r2d3 data=18, viewer = c("browser")



/* Make sure we have a square svg. Tis is important for making sure the color
gradiant remains unaffected by window resizes */
var dim = Math.max(width, height);
if (dim <220) {
  var dim = 220;
}
svg.attr("width", (dim)).attr("height", (dim-(1/3.2*dim)));


// GLOBAL
padding = dim * 0.0625;
var radius = dim / 2 - padding;
var pie_data = [1]; // Don't need real data, this just gives skeleton for element
var maxVal = 0.27;
var angleMin = -110;
var angleMax = 110;
var angleRange = angleMax - angleMin;
innerRadius = ((radius - 10) / 5) * 3;
hubRadius = radius/12;
var numLabels = 6;
transitionMs = 1000;

// FOMARRTING
var labelOffset = -5; // Lower number moves away from graph
var textSize1 = "300%";
var textSize2 = "140%";
xOffset = -dim * 0.0;
yOffset = dim * 1.5 * 0.12; // Higher number moves it downwards
hubColor = "black";
pointerColor = "black";


// Pointer vars
var pointerWidth = hubRadius*2;
var pointerTailLength = 0;
var pointerHeadLengthPercent = 0.9;
pointerHeadLength = Math.round(radius * pointerHeadLengthPercent);
var anglePointStartPadding = 0;
var lineData =  [[pointerWidth / 2, 0],
                [0, -pointerHeadLength],
                [-(pointerWidth / 2), 0],
                [0, pointerTailLength],
                [pointerWidth / 2, 0]];

// HELPER FUNCTIONS
function deg2rad(deg) {
  return  deg * Math.PI / 180;
}

function newAngle(d){
  var ratio = scale(d);
}

// This is for nicer rounding that the simple Math.round()
function roundSpec(value, decimals) {
  return Number(Math.round(value+'e'+decimals)+'e-'+decimals);
}


needleStart = function(degrees, xy){
  if(xy == "y") {
    return radius * Math.sin(deg2rad(degrees+270));
  } else if (xy == "x") {
    return radius * Math.cos(deg2rad(degrees+270));
  }
};

// CONSTRUCTOR FUNCTIONS (I think)
gaugeScale = d3.scaleLinear()
  .domain([0, maxVal])
  .range([0, 1]);

tickActuals = gaugeScale.ticks(numLabels);

var valueToDegrees = d3.scaleLinear() //scaleLinear in d3v4!
  .domain([0, maxVal])
  .range([angleMin, angleMax]);

var color = d3.interpolateRgb("red", "green");

/*  Set up constructor that will convert my data into pie data.
To limit to half a pie chart - set the startAngle and endAngle (in radians) */
var gauge = d3.pie()
  .sort(null)
  .value(function(d) { return d;})
  .startAngle(deg2rad(angleMin))
  .endAngle(deg2rad(angleMax));


// Make arc generator function variable to call later
var arc = d3.arc()
  .outerRadius(radius)
  .innerRadius(innerRadius);


// Pointer constructor
var pointerLine = d3.line().curve(d3.curveLinear);


// BUILDING CHART

/*Create wrapper so that needle rotates around correct element. i.e. we will
  later append the needle to the wrapper, so that they share the same
  coordinate system */
var wrap = svg.append("g")
    .attr("class", "wrap")
    .attr("transform", "translate(" + (radius  + padding) +"," + (radius + padding) + ")");


// Gradient:
// See: https://stackoverflow.com/questions/31912686/how-to-draw-gradient-arc-using-d3-js
//Append a defs (for definition) element to your SVG
var defs = svg.append("defs");
//
var radialGradient = defs.append("radialGradient")
  .attr("id", "radial-gradient")
  .attr("gradientUnits", "userSpaceOnUse")
  .attr("cx", "0%")
  .attr("cy", "400%")
  .attr("r", "300%")
  .attr("fx", "15%")
  .attr("fy", "85%")
  .attr("gradientTransform", "translate(-" + radius + ", -" + radius + ")");

/* Set color for start (0%) and end (100%). Don't change these. To change the
gradient adjust the cx, cy...etc above */
radialGradient.append("stop")
  .attr("offset", "0%")
  .style("stop-color", "#10e209");
radialGradient.append("stop")
  .attr("offset", "5%")
  .style("stop-color", "#10e209");
radialGradient.append("stop")
  .attr("offset", "17%")
  .style("stop-color", "#ffff00");
  radialGradient.append("stop")
  .attr("offset", "25%")
  .style("stop-color", "#ffff00");
radialGradient.append("stop")
  .attr("offset", "60%")
  .style("stop-color", "#8b0000");
radialGradient.append("stop")
  .attr("offset", "100%")
  .style("stop-color", "#8b0000");


/* Then we can create new groups for each incoming wedge, binding the pie-ified data to
the new elements, and translating each group into the center of the chart, so the paths
will appear in the right place.

Note that we're saving a reference to each newly created g in a variable called arcs.
*/
var arcs = wrap.selectAll('g')
  .data(gauge(pie_data))
  .enter().append('g')
    .attr('class', "arc");


/*
Finally, within each new g, we append a path. A paths path description is defined in the
d attribute. So here we call the arc generator, which generates the path information
based on the data already bound to this group: */

//Draw arc paths
arcs.append("path")
  .attr("d", arc)
  .attr("fill", "url(#radial-gradient");



// Append text
var text = svg.append("g")
  .attr("class", "text")
  .append("text")
    .attr("transform", "translate(" + (radius + padding + xOffset) + "," + (radius + padding + yOffset) + ")")
    .attr("font-size", textSize1)
    .attr("font-weight", "bold")
    .attr("text-anchor", "middle");

// Hub
wrap.append('g')
    .attr('class', 'innerCircle')
    .append("circle")
    .attr("cx", 0)
    .attr("cy", 0)
    .attr("r", hubRadius)
    .attr("fill", hubColor);

// Append starting Pointer
var pg = wrap.append('g').data([lineData])
  .attr("class", "pointer");

pointer = pg.append('path')
  .attr('d', pointerLine)
  .attr("transform", 'rotate(' + (angleMin + anglePointStartPadding)  + ")")
  .attr("fill", pointerColor);

// Labels
wrap.append("g")
  .attr('id', 'label')
  .selectAll('text')
    .data(tickActuals)
    .enter().append('text')
      .attr("transform", function(d) {
        var ratio = gaugeScale(d);
        var newAngle = angleMin + (ratio * angleRange);
        return('rotate(' +newAngle + ') translate(0' + (labelOffset - radius) + ')');
      })
      .text(d3.format('.0%'))
      .attr("font-size", textSize2);






// Rendering on data change
r2d3.onRender(function(newVal){
  /* Shiny gives data in %, but need to convert back to integer
  because d3.format will convert back to % in the Labels section... */
  newVal = newVal/100;

  //Not sure why we use svg.select, instead of wrap.select?

  var ratio = gaugeScale(newVal);
  var newAngle = angleMin + (ratio * angleRange);
  pointer.transition()
    .duration(transitionMs)
    .ease(d3.easeElastic.amplitude(0.2).period(0.9))
    .attr("transform", "rotate(" + newAngle + ')');

  text.datum(newVal).text(function(d) {
      if (d*100 < 0.1) {
        return "<0.1%";
      } else {
      return roundSpec(d*100, 1) + "%";
      }
    });

});


