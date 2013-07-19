/* Place all the behaviors and hooks related to the matching controller here.
 All this logic will automatically be available in application.js.
 You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
 */

/*
$("document").ready(function() {
  var checkboxes = $("input");
  for (var i = 0; i < checkboxes.size(); i++) {
    console.log("in for loop");
    console.log($(checkboxes[i]).attr("id"));
    var curbox = $(checkboxes[i]);
    var f = function (i) { console.log(i) };
    curbox.click(f)//(function(i) { 
//      return function() {console.log(i); }
//      }));
  }
})
*/

$("document").ready(function () {
    var results = $(".result");
    var boxes = $(".result input");
    for (var i = 0; i < results.size(); i++) {
      var $result = $(results[i]);
      var $box = $(boxes[i]);
      console.log($result);
      $result.click((function(result, box) {
        return function () { 
                    var isChecked = box.prop("checked");
                    box.prop("checked", !isChecked);
                    $.post("mark", { id: result.prop("id") });
               };
      })($result, $box));
    }
  }
)
/*

$("document").ready(function () {
    var checkboxes = $("input");
    for (var i = 0; i < checkboxes.size(); i++) {
      (function(i) {
        console.log(i);
      })(i);
    }
  }
)
*/
