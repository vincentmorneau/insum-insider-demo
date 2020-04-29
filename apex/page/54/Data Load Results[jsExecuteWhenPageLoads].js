/* apply u-Report--dataLoad CSS class to Data Load Report and hide empty columns */
$("table.standardLook").addClass("u-Report");
$("table.standardLook").addClass("u-Report--standardLook");
$("table.u-Report--standardLook tr:nth-child(1) td:empty").css("display", "none");
$("table.u-Report--standardLook tr th:empty").css("display", "none");
$("table.u-Report--standardLook tr th:empty").each( function (idx, elem) { $("table.u-Report--standardLook tr td[headers=\""+$(elem).attr('id')+"\"]").css("display", "none");});