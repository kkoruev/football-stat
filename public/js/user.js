function edit_information() {
    var new_team = $('#newTeamId')[0].value 
    $.ajax({
        url: "/teams/" + new_team,
        cache: false,
        type: "POST",
        success: function() {
            location.reload(true)
        }
    });
}