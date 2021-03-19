window.onload = () => {
  alert(
    "Preparing file to download, you will be notified once its complete..."
  );
  timeout(4000);
};

function timeout(time) {
  setTimeout(function () {
    alert("Hi");
  }, time);
}

function timeouto(time) {
    setTimeout(function() {
        $.ajax({ url: "/controller/check_if_ready?",
            type : 'GET',
            dataType : 'json',
            success: function(response)
            {
                if(response.value === "success") {
                    var value = confirm("File ready to download ?");
                    if (value == true) {
                        window.location="/controller/download_csv";
                    } else if(value == false) {
                        $.ajax({ url: "/controller/remove_file"})
                    }
                }
                else
                {
                    timeout('4000') // wait 4 seconds 
                }
            },
        });
    }, time);
}
