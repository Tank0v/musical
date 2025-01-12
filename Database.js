function dbInit() {
    var db = LocalStorage.openDatabaseSync("Musical_DB", "", "Musical compositions", 1000000)
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS musical_table (id integer primary key not null, name text not null, artist text not null, album text, duration integer not null, description text, image text, listeners integer not null)')
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}

function dbGetHandle() {
    try {
        var db = LocalStorage.openDatabaseSync("Musical_DB", "",
                                               "Musical compositions", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function dbInsertSong(name, artist, album = null, duration, description = null, image = null, listeners = 0) {
    var db = dbGetHandle();
    var rowid = 0;

    db.transaction(function (tx) {
        // Проверяем, существует ли песня
        var result = tx.executeSql(
            'SELECT id FROM musical_table WHERE name = ? AND artist = ? AND album = ?',
            [name, artist, album]
        );

        if (result.rows.length === 0) {
            // Если песни нет, добавляем её
            tx.executeSql(
                'INSERT INTO musical_table(name, artist, album, duration, description, image, listeners) VALUES(?, ?, ?, ?, ?, ?, ?)',
                [name, artist, album, duration, description, image, listeners]
            );

            var insertResult = tx.executeSql('SELECT last_insert_rowid()');
            rowid = insertResult.insertId;
        } else {
            console.log("Песня уже существует в избранном.");
        }
    });

    return rowid;
}

function dbReadAllSongs() {
    var db = dbGetHandle();
    db.transaction(function (tx) {
        var results = tx.executeSql('SELECT id, name, artist, listeners FROM musical_table');
        for (var i = 0; i < results.rows.length; i++) {
            // Проверяем, существует ли песня в модели
            var songId = results.rows.item(i).id;
            var existsInModel = false;
            for (var j = 0; j < songListModel.count; j++) {
                if (songListModel.get(j).id === songId) {
                    existsInModel = true;
                    break;
                }
            }
            // Если песни еще нет в модели, добавляем её
            if (!existsInModel) {
                songListModel.append({
                    id: songId,
                    name: results.rows.item(i).name,
                    artist: results.rows.item(i).artist,
                    listeners: results.rows.item(i).listeners
                });
            }
        }
    });
}

function dbSongInfo(songId) {
    var db = dbGetHandle();
    db.transaction(function (tx) {
        songModel.clear();

        var results = tx.executeSql(
            'SELECT id, name, artist, album, duration, description, image, listeners FROM musical_table WHERE id = ?', [songId]);

        if (results.rows.length > 0) {
            var song = results.rows.item(0);

            songModel.append({
                id: song.id,
                name: song.name,
                artist: song.artist,
                album: song.album || "",
                duration: song.duration,
                description: song.description || "",
                image: song.image || "",
                listeners: song.listeners
            });
        }
    });
}

function deleteSong(songId) {
    var db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM musical_table WHERE id = ?', [songId])
    })
}

function deleteAll() {
    var db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql('DROP TABLE musical_table')
    })
}

function checkFavorites(name, artist, album = null) {
    var db = dbGetHandle()
    var isInFavorites = false
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT id FROM musical_table WHERE name = ? AND artist = ? AND album = ?', [name, artist, album])
        if (results.rows.length)
            isInFavorites = true;
    })
    return isInFavorites;
}