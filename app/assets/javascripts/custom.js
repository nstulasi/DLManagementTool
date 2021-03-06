$(function () {
        // Initialize the jQuery File Upload widget:
        $('#fileupload').fileupload();
        // 
        // Load existing files:
        $.getJSON($('#fileupload').prop('action'), function (files) {
          var fu = $('#fileupload').data('fileupload'), 
            template;
          template = fu._renderDownload(files)
            .appendTo($('#fileupload .files'));
          // Force reflow:
          fu._reflow = fu._transition && template.length &&
            template[0].offsetWidth;
          template.addClass('in');
          $('#loading').remove();
        });

    });
		$("#creator").live('click',function(){
		$("#new_policy_div").removeClass('disp_none');
		$("#new_policy_div").addClass('disp');
		$("#default_sample_div").removeClass('disp');
		$("#default_sample_div").addClass('disp_none');
		  $("#new_policy_div").animate({
		    height: "auto",
		  }, 1500 );
		});
	$(document).ready(function() {
		$( "#accordion" ).accordion({ autoHeight: false , active:false});
		$( "#society_accordion" ).accordion({ autoHeight: false , active:false});
		$( "#project_user_accordion" ).accordion({ autoHeight: false , active:false});		
		});
			$(function() {
				$("#tabs").tabs();
			});
			//TO-DO : Minify this
			$('.character_submittable').live('change', function() {
				if(document.getElementById('character').checked == true) {
					$('#character_appender').addClass('disp_div');
					$('#character_appender').removeClass('disp_none');
				} else {
					$('#character_appender').addClass('disp_none');
					$('#character_appender').removeClass('disp_div');
				}
				});
// Sets the fill attribute of the circle to red (#f00)
		     $(document).ready(function() {
				$(".type").select2({
    				allowClear: true
				});
			});

			$(document).ready(function() {
				$("#task_priority").select2();
			});
			$(document).ready(function() {
			var arr = [".sequences","#character_encoding","#audio_encoding","#video_encoding","#image_encoding","#text_encoding,#program_encoding"];
			for (var i = 0; i < arr.length; i += 1){
				$(arr[i]).select2({
					placeholder: "Select the type of sequences",
    				allowClear: true
				});
			}
			});
			$(document).ready(function() {
				$("#database_name").select2({
    				placeholder: "Select a database",
    				allowClear: true
				});
			});
$(document).ready(function () {
    $('.checkall').click(function () {
        $(this).parents('fieldset:eq(0)').find(':checkbox').attr('checked', this.checked);
    });
});
 
$(document).ready(function() { $("#user_id").select2({
					placeholder: "Choose user to assign task to",
    				allowClear: true
				}); });

$('.item').live('mouseover',function(){
    $(this).draggable({
    	revert:true
    });
});
      
 $('.ud_diagram_canvas').live('mouseover',function(){
          $(this).droppable({
                tolerance: 'touch',
                over: function() {
                       $(this).removeClass('out').addClass('over');
                },
                out: function() {
                        $(this).removeClass('over').addClass('out');
                },
                drop: function() {
                        $(this).removeClass('over').addClass('out');
                }
        });
      });

$(document).ready(function() {
		$( "#tabs" ).tabs();
	});


$('.submittable').live('click', function() {
  $(this).parents("form[data-remote]").submit();
  $("#alert_div").fadeIn("slow", function () {
  $('#alert_div').text("Diagram saved");});
  setTimeout(function(){
  $("#alert_div").fadeOut("slow", function () {
  $("#alert_div").text(" ");
      });
 
}, 4000);
});

$('.submittable').live('click', function() {
		$(this).parents("form[data-remote]").submit();
		$("#feedback_div").fadeIn("slow", function () {
		$('#feedback_div').text("Collection saved");});
		setTimeout(function(){
		$("#feedback_div").fadeOut("slow", function () {
		$("#feedback_div").text(" ");
		});
		}, 4000);
		});
$('.submittable').live('click', function() {
		$(this).parents("form[data-remote]").submit();
		$("#soc_feedback_div").fadeIn("slow", function () {
		$('#soc_feedback_div').text("Group saved");});
		setTimeout(function(){
		$("#soc_feedback_div").fadeOut("slow", function () {
		$("#soc_feedback_div").text(" ");
		});
		}, 4000);
		});


$('.submittable').live('change', function() {
  if(document.getElementById('Text').checked == true){
  $('#appender').show();}
  else{
  	$('#appender').hide();
  }
});


// we could highlight the checkbox to show it's been clicked:
$('#thing').css("color","yellow");

// or add the updated thing to a list:
$('#things').prepend('<%=escape_javascript render(@thing) %>');

$(document).ready(function (){
	$('#project_start_at').datepicker({dateFormat: 'yy-mm-dd',changeMonth: true, changeYear: true});
	$('#project_end_at').datepicker({dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true});
	$('#task_start_at').datepicker({dateFormat: 'yy-mm-dd',changeMonth: true,changeYear: true});
	$('#task_end_at').datepicker({dateFormat: 'yy-mm-dd',changeMonth: true, changeYear: true});
	$('#event_start_at').datepicker({dateFormat: 'yy-mm-dd',changeMonth: true, changeYear: true});
	$('#event_end_at').datepicker({dateFormat: 'yy-mm-dd',changeMonth: true, changeYear: true});
	$("#phase_start").datepicker({
		onSelect: function(dateText, inst) {
        $("#phase_start").focusin();},
     dateFormat: "yy-mm-dd",
	  onClose: function(dateText, inst) { $(inst.input).focusout(); },
	  changeMonth: true,
	  changeYear: true
	});
	$('#phase_end').datepicker({dateFormat: 'yy-mm-dd', changeMonth: true,changeYear: true});
});


$(document).ready(function() {
  window.database = Exhibit.Database.create();
  if(data!=null){
  window.database.loadData(data);
  }
  window.exhibit = Exhibit.create();
  window.exhibit.configureFromDOM();
});



$(function() {
	$("#treeViewDiv_events").jstree({
		"json_data" : {
			"data" : data_events
		},
		"plugins" : ["themes", "json_data", "ui"]
	}).bind("select_node.jstree", function(e, data)
                    {
                        window.location= data.rslt.obj.data("href"); 
                    })
});

$(function() {
	$("#treeViewDiv_phases").jstree({
		"json_data" : {
			"data" : data_phases,
		},
		"plugins" : ["themes", "json_data", "ui"]
	}).bind("select_node.jstree", function(e, data)
                    {
                        window.location= data.rslt.obj.data("href"); 
                    })
            });

$(function() {
	$("#treeViewDiv_policies").jstree({
		"json_data" : {
			"data" : data_policies,
		},
		"plugins" : ["themes", "json_data", "ui"]
	}).bind("select_node.jstree", function(e, data)
                    {
                        window.location= data.rslt.obj.data("href"); 
                    })
            });
	

$(document).ready(function(){
	$('#dynamic_table').dataTable();
	$('#dynamic_project_table').dataTable();
});

$(document).ready(function(){$('.toggle:not(.toggle-open)') .addClass('toggle-closed') .parents('li') .children('ul') .hide();    

$('.toggle') .click(function(){
   if ($(this) .hasClass('toggle-open')) {
     $(this) .removeClass('toggle-open') .addClass('toggle-closed') .empty('') .append('+') .parents('li') .children('ul') .slideUp(250);
     $(this) .parent('.menutop') .removeClass('menutop-open') .addClass('menutop-closed');
   }else{
     $(this) .parent('.menutop') .removeClass('menutop-closed') .addClass('menutop-open');
     $(this) .removeClass('toggle-closed') .addClass('toggle-open') .empty('') .append('&ndash;') .parents('li') .children('ul') .slideDown(250);
 }
 })
 });
$(document).ready(function(){
  // Binds to the remove task link...
  $('.remove_phase').live('click', function(e){
    e.preventDefault();
    $(this).parents('.phase').remove();
  });

  // Add task link, note that the content we're appending
  // to the tasks list comes straight out of the data-partial
  // attribute that we defined in the link itself.

});

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

    $(document).ready(function() {
      $("#sortable").nestedSortable({
        listType: 'ul',
        items: 'li',
        placeholder: "highlight",
        forcePlaceholderSize: true,
        handle: 'span',
        helper: 'clone',
        opacity: .6,
        revert: 250,
        tabSize: 25,
        tolerance: 'pointer',
        toleranceElement: '> span'
      });
      $("#sortable").disableSelection(); // make links not clickable
      $('#serialize').click(function (){
        var c = {set : JSON.stringify($('#sortable').nestedSortable('toHierarchy', {startDepthCount: 0}))};
        $.post("savesort", c, $('#output').html('<p id="flash_notice">Saved Successfully</p>'));
        return false;
      });
    });
    
$(document).ready(function() {
    // if text input field value is not empty show the "X" button
    $("#custom_field").keyup(function() {
        $("#x").fadeIn();
        if ($.trim($("#field").val()) == "") {
            $("#x").fadeOut();
        }
    });
    // on click of "X", delete input field value and hide "X"
    $("#x").click(function() {
        $("#custom_field").val("");
        $(this).hide();
    });
});

var tl;
$(document).ready(function() {
var eventSource = new Timeline.DefaultEventSource();
  var bandInfos = [
  
    Timeline.createBandInfo({
    	eventSource:    eventSource,
        date:           "July 28 2012 00:00:00 GMT",
        width:          "70%",
        trackHeight:    1,
        trackGap:       0.3, 
        intervalUnit:   Timeline.DateTime.MONTH, 
        intervalPixels: 100
    }),
    Timeline.createBandInfo({
    	showEventText:  false,
        trackHeight:    0.2,
        trackGap:       0.2,
    	eventSource:    eventSource,
        date:           "Jun 28 2011 00:00:00 GMT",
        width:          "30%", 
        intervalUnit:   Timeline.DateTime.YEAR, 
        intervalPixels: 200
    })
  ];
  bandInfos[1].syncWith = 0;
  bandInfos[1].highlight = true;
  tl = Timeline.create(document.getElementById("my-timeline"), bandInfos);
  eventSource.loadJSON(phases, '');
  
});
