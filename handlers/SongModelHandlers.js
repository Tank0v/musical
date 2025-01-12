function onCountChangedHandler(currentSongModel, detailsPage, layout, addToFavoritesButton, converter, JS) {
    if (currentSongModel.count) {
        var currentSong = detailedSongModel.get(0);
        detailsPage.detailedSongName = `<b>Название:</b> ${currentSong.name}`;
        detailsPage.detailedSongArtist = `<b>Исполнитель:</b> ${currentSong.artist}`;

        if (currentSong.description) {
            detailsPage.detailedSongDescription.visible = true;
            detailsPage.detailedSongDescription.text = `<b>Описание:</b> ${currentSong.description}`;
        } else {
            detailsPage.detailedSongDescription.visible = false;
        }

        detailsPage.detailedSongListeners = `<b>Прослушали: </b> ${currentSong.listeners}`;
        detailsPage.detailedSongDuration = `<b>Длительность: </b> ${currentSong.duration > 0 ? converter.msToTime(currentSong.duration) : "Длительность трека отсутствует"}`;
        detailsPage.detailedSongAlbum = currentSong.album ? `<b>Альбом:</b> ${currentSong.album}` : '';

        if (currentSong.albumImage) {
            detailsPage.detailedSongAlbumImage.visible = true;
            detailsPage.detailedSongAlbumImage.source = currentSong.albumImage;
        } else {
            detailsPage.detailedSongAlbumImage.visible = false;
        }

        layout.currentIndex = 1;

        // Выключить добавление в избранное, когда элемент уже добавлен
        addToFavoritesButton.enabled = !JS.checkFavorites(currentSong.name, currentSong.artist, currentSong.album);
    }
}