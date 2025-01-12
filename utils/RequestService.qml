import QtQuick 2.0

//Запросы к сайту
Item {
  property string apiKey: '1dcd34203be2c785de65cb5ef3bf6a8f';

  function getSongsByName(dataModel, name) {
    var request = new XMLHttpRequest()
    request.open('GET', `https://ws.audioscrobbler.com/2.0/?method=track.search&track=${name}&api_key=${this.apiKey}&format=json`, true);
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                layout.isLabelNotFoundVisible = false; // прячем надпись
                dataModel.clear()

                var json = JSON.parse(request.responseText)
                for (var item of json.results.trackmatches.track) {
                    dataModel.append({
                      "name": item.name, //resize(item.name, 55),
                      "artist": item.artist, //resize(item.artist, 55),
                      "listeners": item.listeners
                    })
                }
                layout.isLabelNotFoundVisible = dataModel.count == 0; // показываем надпись, если модель пуста
            } else {
                console.log("HTTP:", request.status, request.statusText)
            }
        }
    }
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.setRequestHeader('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.5993.732 YaBrowser/23.11.1.732 Yowser/2.5 Safari/537.36');
    request.send()
  }

  function getSongsByArtist(dataModel, artist) {
    var request = new XMLHttpRequest()
    request.open('GET', `https://ws.audioscrobbler.com/2.0/?method=track.search&track= &artist=${artist}&api_key=${this.apiKey}&format=json`, true);
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                layout.isLabelNotFoundVisible = false; // прячем надпись
                dataModel.clear()

                var json = JSON.parse(request.responseText)
                for (var item of json.results.trackmatches.track) {
                    dataModel.append({
                      "name": item.name, //resize(item.name, 55),
                      "artist": item.artist, //resize(item.artist, 55),
                      "listeners": item.listeners
                    })
                }
                layout.isLabelNotFoundVisible = dataModel.count == 0; // показываем надпись, если модель пуста
            } else {
                console.log("HTTP:", request.status, request.statusText)
            }
        }
    }
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.setRequestHeader('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.5993.732 YaBrowser/23.11.1.732 Yowser/2.5 Safari/537.36');
    request.send()
  }

  function getSongsByAlbum(dataModel, album) {
    var request = new XMLHttpRequest()
    request.open('GET', `https://ws.audioscrobbler.com/2.0/?method=album.search&album=${album}&limit=5&api_key=${this.apiKey}&format=json`, true);
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                layout.isLabelNotFoundVisible = false; // прячем надпись
                dataModel.clear()

                var json = JSON.parse(request.responseText)
                if (json.results.albummatches.album) {
                    for (var album of json.results.albummatches.album) {
                        getAlbumInfo(dataModel, album.artist, album.name)
                    }
                }
            } else {
                console.log("HTTP:", request.status, request.statusText)
            }
        }
    }
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.setRequestHeader('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.5993.732 YaBrowser/23.11.1.732 Yowser/2.5 Safari/537.36');
    request.send()
  }

  function getAlbumInfo(dataModel, artist, album) {
    var request = new XMLHttpRequest()
    request.open('GET', `https://ws.audioscrobbler.com/2.0/?method=album.getInfo&artist=${artist}&album=${album}&api_key=${this.apiKey}&format=json`, true);
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                var json = JSON.parse(request.responseText)
                if (json.album?.tracks?.track) {
                  for (var item of json.album.tracks.track){
                    dataModel.append({
                      "name": item.name,
                      "artist": item.artist.name,
                      "duration": item.duration ?? 0
                    })
                  }
                }
                layout.isLabelNotFoundVisible = dataModel.count == 0; // показываем надпись, если модель пуста
            } else {
                console.log("HTTP:", request.status, request.statusText)
            }
        }
    }
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.setRequestHeader('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.5993.732 YaBrowser/23.11.1.732 Yowser/2.5 Safari/537.36');
    request.send()
  }

  function getSongInfo(dataModel, track, artist) {
    var request = new XMLHttpRequest()
    var modifiedTrack = track.replace(/&/g, '%26');
    var modifiedArtist = artist.replace(/&/g, '%26');
    request.open('GET', `https://ws.audioscrobbler.com/2.0/?method=track.getInfo&track=${modifiedTrack}&artist=${modifiedArtist}&api_key=${this.apiKey}&format=json`, true);

    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                var song = JSON.parse(request.responseText).track

                var imageUrl = null;
                if (song.album) {
                  for(var image of song.album.image) {
                    if (image.size === 'large') {
                      imageUrl = image['#text'];
                    }
                  }
                }

                dataModel.clear()
                dataModel.append({
                  "name": song.name,//resize(track.name, 55),
                  "artist": song.artist.name,//resize(track.artist.name, 55),
                  "description": (song?.wiki?.summary ? song.wiki.summary.replace('Read more on Last.fm', '').slice(0,-1) : ''),
                  "listeners": song.listeners,
                  "duration": song.duration,
                  "album": (song.album ? song.album.title : ''),
                  "albumImage": (imageUrl ?? '')
                })
            } else {
                console.log("HTTP:", request.status, request.statusText)
            }
        }
    }
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.setRequestHeader('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.5993.732 YaBrowser/23.11.1.732 Yowser/2.5 Safari/537.36');
    request.send()
  }
}