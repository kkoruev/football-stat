function add_team() {
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

function delete_team(team_name) {
    $.ajax({
        url: "/teams/" + team_name,
        cache: false,
        type: "DELETE",
        success: function() {
            location.reload(true)
        }
    });
}
