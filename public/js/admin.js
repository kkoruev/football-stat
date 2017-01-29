function add_team() {
    alert("HERE")
    var new_team = $('#newTeamId')[0].value 
    alert(new_team)
    $.ajax({
        url: "/teams",
        cache: false,
        type: "POST",
        data: {
            name: new_team
        }, 
        success: function() {
            alert("NICE A")
        }
    });
}
