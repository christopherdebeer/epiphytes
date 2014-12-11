var s3Uploader = (function () {

    var POLICY = "eyJleHBpcmF0aW9uIjoiMjAyMC0xMi0zMVQxMjowMDowMC4wMDBaIiwiY29uZGl0aW9ucyI6W3siYnVja2V0Ijoid2lyZWQyMDAifSxbInN0YXJ0cy13aXRoIiwiJGtleSIsIiJdLHsiYWNsIjoicHVibGljLXJlYWQifSxbInN0YXJ0cy13aXRoIiwiJENvbnRlbnQtVHlwZSIsIiJdLFsiY29udGVudC1sZW5ndGgtcmFuZ2UiLDAsNTI0Mjg4MDAwXV19";
    var AWS_KEY = "AKIAJMBFZSOZAL4VYPWA";
    var SIGNATURE = "warGelZmD9fe+oLDw0ljSzWpjQM=";
    var BUCKET = "wired200";

    function upload(options) {

        var deferred = $.Deferred();

            
        var fd = new FormData(),
            key = ("uploads/" + (new Date).getTime()),
            type = options.type,
            blob = options.blob,
            filename = options.name

        fd.append('key', key);
        fd.append('acl', 'public-read'); 
        fd.append('Content-Type', type);      
        fd.append('AWSAccessKeyId', AWS_KEY);
        fd.append('policy', POLICY)
        fd.append('signature', SIGNATURE);

        fd.append("blob",blob, filename);

        fd.append("filename","blob" );

        var xhr = new XMLHttpRequest();

        xhr.upload.addEventListener("progress", uploadProgress, false);
        xhr.addEventListener("load", uploadComplete, false);
        xhr.addEventListener("error", uploadFailed, false);
        xhr.addEventListener("abort", uploadCanceled, false);

        xhr.open('POST', 'https://'+BUCKET+'.s3.amazonaws.com/', true); //MUST BE LAST LINE BEFORE YOU SEND 

        xhr.send(fd);

        return 0; //Promise


    }

    function uploadProgress(evt) {
        if (evt.lengthComputable) {
          var percentComplete = Math.round(evt.loaded * 100 / evt.total);
          console.log( percentComplete.toString() + '%' );
        }
        else {
          console.log( 'unable to compute' );
        }
    }  

    function uploadComplete(evt) {
        /* This event is raised when the server send back a response */
        console.log("Done - " + evt.target.responseText );
    }

    function uploadFailed(evt) {
        console.log("There was an error attempting to upload the file." + evt);
    }

    function uploadCanceled(evt) {
        console.log("The upload has been canceled by the user or the browser dropped the connection.");
    }

    return {
        upload: upload
    }

}());