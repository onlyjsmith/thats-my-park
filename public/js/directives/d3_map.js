'use strict';

(function () {

  function d3Map(SlugifyNameService) {
    return {
      restrict: 'E',
      scope: {
        thematicData: '@',
        geomData: '=',
        index: '@'
      },
      link: function(scope, element, attr) {

        //console.log(JSON.parse(scope.thematicData));

        var el = element[0],
            width,
            height,
            thematicData = JSON.parse(scope.thematicData),
            numericData = d3.values(thematicData).filter(function(el){
              return typeof el === "number" ? el : void 0;
            }),
            scale,
            svg,
            paths,
            geoData,
            regions,
            projection,
            path;

        function slugifyName(name){
          return SlugifyNameService.slugify(name.replace(' Euro Region', ''));
        }

        function resize() {
          svg.attr({width: width, height: height});
          projection
            .scale(width*10)
            .translate([width / 2, height / 2]);
          path = d3.geo.path()
            .projection(projection);
          paths.each(function(d) {
            d3.select(this).attr('d', path);
          })
        }

        scale = d3.scale.quantize()
          .domain( [d3.min(numericData), d3.max(numericData)] )
          .range(d3.range(9).map(function(i) { return "q" + i + "-9"; }));

        svg = d3.select(el).append('svg');

        regions = topojson.feature(
          //topojson.presimplify(scope.geomData),
          scope.geomData,
          scope.geomData.objects.european_region_england_wgs84_s);

        projection = d3.geo.albers()
          .center([.5, 52.8])
          .rotate([2.4, 0])
          .parallels([50, 55]);

        paths = svg.selectAll('.region-' + scope.index)
          .data(regions.features)
        .enter().insert('path')
          .attr("class", function(d) {
            return "q " + scale(thematicData[slugifyName(d.properties.NAME)]); });

        scope.$watch(function(){
          width = element.parent()[0].clientWidth;
          var h = element.parent()[0].clientHeight;
          height = width*1.1,
          h = element.parent()[0].clientHeight;
          return width + h;
        }, resize);

      }
    };
  }

  angular
    .module('aLevelsApp')
    .directive('d3Map', d3Map);

})();