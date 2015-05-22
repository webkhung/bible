chrome.storage.sync.set({'user_id': 'abcdef'}, function() {
    // Notify that we saved.
    console.info('Settings saved');
});

// chrome.storage.sync.get(null, function (data) { console.info(data) });
