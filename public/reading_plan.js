var today = formatDate(new Date());
var objPlans = {};
var userId = '';
var userName = '';
var htmlRender = new HTMLRender();
var DAILY_MEMORIZED_GOAL = 4;
var HOST = 'bibleverseapp.com';
//var HOST = 'localhost:3001';
var memorizedCount = 0;
var game = new Game();
var textAnimations = ['rotateIn', 'rotateInDownLeft', 'rotateInDownRight', 'fadeIn', 'fadeInUp', 'fadeInDown',
    'fadeInLeft', 'fadeInRight', 'fadeInDownBig', 'bounceIn', 'bounceInDown', 'flash']; // pulse, flip, 'fadeInLeftBig', 'fadeInRightBig'
var rated = false;
var bgImage;

var readingPlans = [
    {
        "id": "1",
        "name": "Being Thankful",
        "badge": "images/greystyle_08_badge.png",
        "description": "",
        "days": ["1Chronicles.23:30","John.14:27","Romans.5:5","Matthew.6:26","Psalm.20:4","Colossians.3:17","1Thessalonians.5:18","James.1:17","Philippians.4:6"]
    },
    {
        "id": "2",
        "name": "Love Part 1",
        "badge": "images/greenstyle_08_badge.png",
        "description": "",
        "days": ["Luke.6:31","Luke.6:35","John.8:13","Romans.12:9","Mark.12:31","Romans.13:10","1Corinthians.13:4-8","1Corinthians.13:13","Ephesians.4:2","1Peter.4:8","1John.4:7","1John.4:18-19","John.15:13","Ephesians.5:25"]
    },
    {
        "id": "3",
        "name": "Love Part 2",
        "badge": "",
        "description": "",
        "days": ["Ephesians.5:33","Colossians.3:14","Proverbs.10:12","Proverbs.17:17","1John.3:16-18","1John.4:8","John.3:16","Psalm.18:1","Matthew.22:27-29","Deuteronomy.10:12-19","Song of Solomon.8:4-8","Matthew.6:24","Matthew.22:37-39","Matthew.23:6-8"]
    },
    {
        "id": "4",
        "name": "Temptation",
        "badge": "images/greenstyle_08_badge.png",
        "description": "",
        "days": ["James.1:14", "Hebrews.2.18", "Hebrews.4.15", "James.4.7", "Romans.6.6-13", "Ephesians6.10-11", "1Peter.5:8-9"]
    },
    {
        "id": "5",
        "name": "Worry",
        "badge": "",
        "description": "",
        "days": ["Proverbs.3:5-6", "Philippians.4:6-7", "Matthew.11:28-30", "John.14:27", "Jeremiah.17:5-8", "Colossians.3:15", "2Thessalonians.3:16", "Psalm.55:22", "Proverbs.12:25", "1Peter.5:6-8", "Psalm.23:4", "Hebrews.13:5-6"]
    },
    {
        "id": "6",
        "name": "Forgiveness",
        "badge": "",
        "description": "",
        "days": ["Matthew.6:14-15","1John.1:9","Isaiah.43:25-26","Acts.3:19","Isaiah.1:18","2.Corinthians.5:17","Ephesians.1:7","Hebrews.10:17","Daniel.9:9","Colossians.1:13-14","Psalm.103:12","Numbers.14:19-21","Micah.7:18-19","Matthew.6:9-15","Mark.11:25","Matthew.26:28"]
    },
    {
        "id": "7",
        "name": "Encouragement",
        "badge": "",
        "description": "",
        "days": ["Proverbs.18:10","Proverbs.3:5-6","Isaiah.41:10","John.14:27","John.16:33","Psalm.46:1-3","2Timothy.1:7","Psalm.16:8","Psalm.55:22","1Peter.5:7","Isaiah.26:3","Psalm.118:14-16","Psalm.119:114-115","Psalm.119:25","Psalm.119:50","Psalm.119:71","Psalm.120:1"]
    },
    {
        "id": "8",
        "name": "Anger",
        "badge": "",
        "description": "",
        "days": ["James.1:19-20","Proverbs.29:11","James.1:20","Proverbs.19:11","Ecclesiastes.7:9","Proverbs.15:1","Proverbs.15:18","Colossians.3:8","James.4:1-2","Proverbs.16:32","Proverbs.22:24","Matthew.5:22","Psalm.37:8-9","Psalm.7:11","2 Kings.11:9-10","2 Kings.17:18","Proverbs.14:29"]
    },
    {
        "id": "9",
        "name": "Success",
        "badge": "",
        "description": "",
        "days": ["Philippians.4:13","Psalm.37:4","Psalm.1:1-3","Proverbs.16:3","1.Kings 2:3","Matthew.16:26-27","Luke.16:10-11","Romans.12:2","Isaiah.41:10","Philippians.4:6","Deuteronomy.8:18","Jeremiah.17:7"]
    },
    {
        "id": "10",
        "name": "Your Body",
        "badge": "",
        "description": "",
        "days": ["1Corinthians.6:19-20", "1Corinthians.3:16-17","Romans.12:1-2","1Corinthians.10:31","1Timothy.4:8","1Timothy.5:23","Matthew.6:22-23","1Corinthians.15:44","Philippians.1:20","1Corinthians.12:27","Psalm.100:3","Romans.12:4"]
    },
    {
        "id": "11",
        "name": "Money",
        "badge": "",
        "description": "",
        "days": ["Matthew.6:21","Malachi.3:10","Ecclesiastes.5:10","Romans.13:8","Psalm.37:16-17","Proverbs.13:11","Hebrews.13:5","Matthew.19:21","Proverbs.17:16","Matthew.6:24","Luke.3:14","Exodus.22:25","1Timothy.6:10","Deuteronomy.23:19","Matthew.21:12-13","1Timothy.6:17-19","Luke.12:33","Deuteronomy.15:7","Matthew.6:1-4","Mark.12:41-44","Proverbs.10:4","Revelation.3:17","Luke.16:13","Matthew.13:22","2Chronicles.1:11-12","1Peter.5:2-3","1Samuel.2:7","Proverbs.3:9"]
    }
]

function Plan(json){
    this.json = json;
    this.id = json["id"];
    this.name = json["name"];
    this.description = json["description"];
    this.days = json["days"];
    this.badge = json["badge"];
    this.added = false;
    this.completedOn = []; // index is day-1, value is the date
    this.numOfDays = this.days.length;
    this.numDaysFinished = function() { return this.completedOn.length; }
    this.lastCompletedDate = function() { return this.completedOn[this.completedOn.length - 1]; }
    this.dayCompleted = function(){
        this.completedOn[this.completedOn.length] = today; // formatDate(new Date());
    }
    this.nextVerse = function(){
        if(this.completed()){
            return "It is finished!";
        }
        else {
            return this.days[this.numDaysFinished()];
        }
    }
    this.completed = function(){
        return this.added && this.numDaysFinished() >= this.numOfDays;
    }
}

function saveData(){
    var userData = { "plans" : {} }
    for(var planId in objPlans){
        var plan = objPlans[planId];
        if(plan.added){
            userData["plans"][plan.id.toString()] = plan.completedOn;
        }
    }
    userData['userId'] =  userId;
    userData['userName'] =  userName;
//    chrome.storage.sync.set(userData);
}

function Game(){
    this.hideWords = function(text, difficulty, memorizedCount){
        var txttmp = text.split(/\s+/);
        var randoms = getRandom(txttmp.length, txttmp.length);
        var toPick = 3; // Math.floor(txttmp.length/ Math.min(txttmp.length,ratio+1));
        var minCharsCount = 3;
        // if(difficulty > 3){
        //  minCharsCount = 3;
        // }

//        console.log('difficulty ' + difficulty);
//        console.log('memorizedCount ' + memorizedCount);
//        console.log('text ' + text);
//        console.log('txttmp.length ' + txttmp.length);
//        console.log('toPick ' + toPick);
//        console.log('difficulty' + difficulty) ;
//        console.log('--------------') ;

        var picked = 0;
        var i=0;
        while(picked < toPick && i < randoms.length){
            var currWord = txttmp[randoms[i]-1]
            if(txttmp[randoms[i]-1].length >= minCharsCount){
                txttmp[randoms[i]-1] = ' <input style=\'width:' + (currWord.length * 18) + 'px\' class=missingWord type=text data-answer=\'' + currWord + '\' placeholder=\'' + game.maskWord(currWord, difficulty) + '\'>';
                picked++;
            }
            i++;
        }
        return txttmp.join(' ');
    }

    this.replaceOneCharacter = function(word, index, character) {
        return word.substr(0, index) + character + word.substr(index+character.length);
    }

    this.maskWord = function(word, difficulty){
        var wordLen = word.length;
        var maskedWord = Array(wordLen+1).join("*")

        var every_n_chars_1_char_reveals = 1;
        if(difficulty == 5){
            every_n_chars_1_char_reveals = wordLen;
        }
        else if(difficulty == 4){
            every_n_chars_1_char_reveals = 4;
            maskedWord = game.replaceOneCharacter(maskedWord, 0, word.charAt(0))
        }
        else if(difficulty == 3){
            every_n_chars_1_char_reveals = 3;
            maskedWord = game.replaceOneCharacter(maskedWord, 0, word.charAt(0))
        }
        else if(difficulty == 2){
            every_n_chars_1_char_reveals = 3;
            maskedWord = game.replaceOneCharacter(maskedWord, 0, word.charAt(0))
        }
        else if(difficulty == 1){
            every_n_chars_1_char_reveals = 2;
            maskedWord = game.replaceOneCharacter(maskedWord, 0, word.charAt(0))
        }

        var ran = getRandom(Math.floor(wordLen/every_n_chars_1_char_reveals), wordLen);

        for(var i=0; i<ran.length; i++){
            maskedWord = game.replaceOneCharacter(maskedWord, ran[i]-1, word.charAt(ran[i]-1))
        }
        return maskedWord;
    }

    this.replaceVerses = function(data, memorizedCount){
        $p = $(data);
        var final = '';

        var totalSentence = 0;
        $p.contents().each(function(){
            if(this.nodeType == 3 && $(this).parent().prop('className') != 'scripture') {
                totalSentence++;
            }
            else {
                if ($(this).parent().prop('className') == 'scripture'){
                }
                else if($(this).prop('className') == 'v'){
                }
                else {
                    totalSentence++;
                }
            }
        });

        var hideSentence = 0;
        var difficulty = memorizedCount;
        if(difficulty == 0){
            hideSentence = 0;
        }
        else if(difficulty == 1){
            hideSentence = Math.min(1, totalSentence);
        }
        else if(difficulty == 2){
            hideSentence = Math.min(1, totalSentence);
        }
        else if(difficulty == 3){
            hideSentence = Math.min(2, totalSentence);
        }
        else if(difficulty == 4){
            hideSentence = Math.max(1, totalSentence-1);
        }
        else if(difficulty == 5){
            hideSentence = totalSentence;
        }

        var ran = getRandom(hideSentence, totalSentence)

        var sentenceCounter = 0;
        $p.contents().each(function(){
            if($(this).parent() && ($(this).parent().prop("tagName").toLowerCase() == 'h2' || $(this).parent().prop("tagName").toLowerCase() == 'h3')){

            }
            else if(this.nodeType == 3 && $(this).parent().prop('className') != 'scripture') {
                sentenceCounter++;
                if(numInArray(sentenceCounter, ran)){
                    final += game.hideWords($(this).text(), difficulty, memorizedCount);
                }
                else {
                    final += $(this).text();
                }
            }
            else {
                if ($(this).parent().prop('className') == 'scripture'){
                    final +=$(this).parent().prop('outerHTML');
                }
                else if($(this).prop('className') == 'v'){
                    final +=$(this).prop('outerHTML');
                }
                else {
                    sentenceCounter++;
                    if(numInArray(sentenceCounter, ran)){
                        final += game.hideWords($(this).text(), difficulty, memorizedCount);
                    }
                    else {
                        final += $(this).text();
                    }
                }
            }
            final = final + ' ';
        });
        return final;
    }
}

function showTicks(memorizedCount){
    $('#ticks .tick-circle').removeClass('filled').find('span').hide();
    if(memorizedCount > 0){
        for(var i=0; i < memorizedCount-1; i++){
            $('#ticks .tick-circle').eq(i).addClass('filled').find('span').show();
        }
    }
}

function HTMLRender(){
    this.fetchMemorized = function(){
        $.get('http://' + HOST + '/memorized_verses', { user_id: userId }, function(data){
            var json = JSON.parse(data);
            $('#memorized-verses').empty();
            $('#memorized-link').show();
            $('#memorized-count').text(json.length);
            var last = '';
            var versesCount = 0;
            for(var i=0; i<json.length; i++){
                var key = json[i][0] + '-' + json[i][1];
                if (last != key) {
                    last = key;
                    versesCount++;
                    $verse = $('<a />').attr({
                        href: '#',
                        class: 'popup-text'
                    }).text(objPlans[json[i][0]].name + ' Day ' + json[i][1]);
                    $verse.attr('data-plan-id', json[i][0]);
                    $verse.attr('data-plan-day', json[i][1]);
                    $verse.click(memorizedVersesClicked);
                    $('#memorized-verses').append($verse);
                }
            }

            $('#memorized-verses').prepend("<h2>One of the most powerful ways you can transform your spiritual life is to learn to memorize Scripture.</h2>");

            if(versesCount == 0)
            {
                $('#memorized-verses').prepend('<h1>You Haven\'t Memorized Any Verses Yet</h1>');
            }
            else {
                $('#memorized-verses').prepend('<h1>You Memorized ' + versesCount + ' Verses ' + json.length + ' Times</h1>');
            }

//            $('#memorized-verses').append("<h3>&#8220;Guard my words as your most precious possession. Write them down and also keep them deep within your heart.&#8221; <span class=''>Proverbs 7:2</span></h3>");
        });
    }

    this.fetchBgRating = function(){

        $.get('http://' + HOST + '/bg_rating', function(data){
            var json = JSON.parse(data);
            $ul = $('<ul />');
            $('#bg-rating').append($ul);

            $ul.append('<li>TOTAL VOTES: '+ json['total'] +'</li><li></li>');
            $ul.append('<li><span class=symbol>&#10003;</span> HIGHLY RATED:</li>');
            for(var i=0; i < json['high'].length && i < 5; i++){
                var linkBg = $('<a />').attr({
                    href: 'images/' + json['high'][i],
                    target: '_blank'
                }).text(json['high'][i].split('.')[0]);
                linkBg.attr('data-rate', 'high');
                linkBg.click(ratedBgClicked);
                var li = $('<li />');
                $ul.append(li.append(linkBg));
            }

            $ul.append('<li><span class=symbol>&#10008;</span> LOWLY RATED:</li>');
            for(var i=0; i < json['low'].length && i < 5; i++){
                var linkBg = $('<a />').attr({
                    href: 'images/' + json['low'][i],
                    target: '_blank'
                }).text(json['low'][i].split('.')[0]);
                linkBg.attr('data-rate', 'low');
                linkBg.click(ratedBgClicked);
                var li = $('<li />');
                $ul.append(li.append(linkBg));
            }
        });
    }

    this.fetchUsers = function(){
//        $.get('http://' + HOST + '/users', function(data){
//            $('#users').html(data);
//        });
        $.get('http://' + HOST + '/users_count', function(data){
            $('#users-count').html(data);
        });
    }

    this.showAddedPlans = function(selectedPlanId){
        $plan = $('#added-plans');
        $plan.empty();
        for(var planId in objPlans){
            var plan = objPlans[planId];
            if(plan.added){
                $container = $("<div class='plan-container'>")
                $container.attr('id', 'added-plan-' + plan.id);

                if(plan.completed()) {
                    $container.append("<div class='plan-badge'><span class='circle circle-solid-" + planId + "'><img src='images/star.png'></span></div>");
                }
                else {
                    $container.append("<div class='plan-badge'><span class='circle circle-solid-" + planId + "'><span class='currentDay'>Day " + plan.completedOn.length + "</span></span></div>");
                }

                $rightCol = $("<div class='plan-right'>");

                $addedPlan = $('<div>');
                $addedPlan.text(plan.name);
                $addedPlan.attr('class', 'added-plan');
                $rightCol.append($addedPlan);

                $jqmeter = $("<div id='jmeter" + plan.id + "' class='jmeter'>");
                $jqmeter.jQMeter({
                    goal : plan.days.length.toString(),
                    raised : plan.completedOn.length.toString(),
                    width : '150px',
                    height : '26px',
                    bgColor : '#dadada',
                    barColor : '#f09246',
                    displayTotal: false
                });
                $rightCol.append($jqmeter);

                $container.append($rightCol);
                $plan.append($container);
            }
        }

        $('#added-plan-' + selectedPlanId + ' .circle').addClass('blink_me');
    }

    this.screenUserName = function() {
        $('#new-plan-link').hide();
        $('#user-name-container').show();
    }

    this.screenPlanSelector = function(){
        $('#passages-container, #new-plan-link').hide();

        $planSelector = $('#plans-selector');
        $planSelector.empty();
        $planSelector.append('<div id="plansSelectorHeader"></div>');

        var numPlansAdded = 0;
        for(var planId in objPlans){
            var plan = objPlans[planId];
            $container = $("<div class='plan-container'>")
            $rightCol = $("<div class='plan-right'>");
            $rightCol.append("<span class='popup-text'>" + plan.numOfDays + ' Days on ' + plan.name + "</span>");
            $meta = $("<span class='plan-meta'>");
            if(plan.added){
                numPlansAdded++;
                if(plan.completed()){
                    $meta.append(" Completed <img src='images/star22.png'>");
                }
                else {
                    $meta.append(' Added');
                }
            }
            else {
                var addPlanLink = $('<a />').attr({ class: 'myButtonSmallLink', href: '#' }).text('Add');
                addPlanLink.click({ param1: planId }, addPlanLinkClicked)
                $meta.append(addPlanLink);
            }
            $rightCol.append($meta);
            $container.append($rightCol);
            $planSelector.append($container);
        }
        var addPlansText = '<h1><span class=username>' + userName + ',</span> Make God\'s Word Part Of Your Day!</h1><h2>Select a Plan Below</h2>';
        $planSelector.find('#plansSelectorHeader').html(addPlansText);
        $planSelector.append("<div style='text-align: center'><a id='plans-close' class='myButton' href='#'>Close</a></div>");
        $planSelector.show();
    }

    this.newGradient = function() {
        var c1 = {
            r: Math.floor(Math.random()*0) + 100,
            g: Math.floor(Math.random()*155) + 100,
            b: Math.floor(Math.random()*155) + 100
        };
        var c2 = {
            r: Math.floor(Math.random()*0) + 150,
            g: Math.floor(Math.random()*255) + 0,
            b: Math.floor(Math.random()*255) + 0
        };
        c1.rgb = 'rgb('+c1.r+','+c1.g+','+c1.b+')';
        c2.rgb = 'rgb('+c2.r+','+c2.g+','+c2.b+')';
        return 'radial-gradient(at top left, '+c1.rgb+', '+c2.rgb+')';
    }

    this.newGradient2 = function() {
        var c1 = {
            r: Math.floor(Math.random()*255),
            g: Math.floor(Math.random()*255),
            b: Math.floor(Math.random()*255)
        };
        var c2 = {
            r: Math.floor(Math.random()*255),
            g: Math.floor(Math.random()*255),
            b: Math.floor(Math.random()*255)
        };
        c1.rgb = 'rgb('+c1.r+','+c1.g+','+c1.b+')';
        c2.rgb = 'rgb('+c2.r+','+c2.g+','+c2.b+')';
        return 'radial-gradient(at top left, '+c1.rgb+', '+c2.rgb+')';
    }

    this.screenTodayVerses = function(data, planId, day){
        console.log('screenTodayVerses ' + planId + ',' + day);
        $('#reveal-button').removeClass('no-link').data('planId', planId).data('day', day);

        var verses = game.replaceVerses(data, memorizedCount);
        $('#passages').empty().append(verses);

        // READ SCREEN
        if(memorizedCount == 0){
            var animation = textAnimations[getRandom(1, textAnimations.length)[0]-1];
            $('#passages').textillate({ in: { effect: animation, delay: 30, shuffle: false, callback: function(){
                bgClear();
                $('#reveal-button').hide().css('visibility','visible').text('Memorize').data('start-memorize', true).fadeIn('slow');
                usageType = 'VIEWED-LIKE'
                htmlRender.fetchUsers();
                $.get('http://' + HOST + '/usage', { usage_type: usageType, plan_id: planId, day: day, user_id: userId, user_name: userName, details: verses.length });
            }}});

            $('#hint-button, #ticks').hide();
        }
        // GAME SCREEN
        else {
            $('#reveal-button').css('visibility','visible').text('Done').data('start-memorize', false);
            $('#hint-button').show().removeClass('no-link').data('planId', planId).data('day', day);
            $('#ticks').show();
            $('#message').html('Fill in the blank spaces');
            showTicks(memorizedCount);
        }
    }

    this.showFeedback = function(){
        $('#feedback').show();
    }
}

function versesProcess(data, planId, day){
    console.log('versesProcess ' + ',' + data  + ',' + planId  + ',' + day);
    htmlRender.screenTodayVerses(data, planId, day);
}

function versesNext(planId, day){
    console.log('versesNext ' + planId + ' ' + day);
    if(planId !== undefined && day !== undefined){
        versesFetch(planId, day);
        return;
    }
    else {
        // Fetch a verse that is not shown today first.
        for(var planId in objPlans){
            var plan = objPlans[planId];
            if(plan.added && !plan.completed() && plan.lastCompletedDate() != today) {
                versesTodayCompleted(planId);
                var day = plan.numDaysFinished();
                versesFetch(planId, day);
                return;
            }
        }

        var randomPlan = randomAddedPlan();
        if(randomPlan){
            console.log('versesNext from random plan');
            versesFetch(randomPlan.id, randomPlan.numDaysFinished());
            return;
        }
    }

    htmlRender.screenPlanSelector();
}

function versesFetch(planId, day){
    console.log('versesFetch ' + planId + ',' + day);

    $('#passages-container').show();
    var key = 'planId' + planId + '-' + today;
    $.get('http://' + HOST + '/verses', { plan_id: planId, day: day, user_id: userId, user_name: userName }, function(verses){
        var data = {}
        data[key] = verses;
//        chrome.storage.sync.set(data);
        versesProcess(verses, planId, day);
        htmlRender.fetchMemorized();
    });
    htmlRender.showAddedPlans(planId);
    $('#rate-background').show();
    $('#passages').html('Loading');
}

function bgBlock(){
    $('.bg').removeClass('bgClear').addClass('bgBlock').toggleClass('hidden');
}

function bgClear(){
    $('.bg').addClass('bgClear').toggleClass('hidden');
}

function rollBg() {
    bgImage = "bg" + (Math.floor(Math.random() * 44) + 1) + ".jpg";
    $('body').css('background-image', "url('images/" + bgImage + "')");
    $('.bg.hidden').css('background', htmlRender.newGradient());
    $('.bg').toggleClass('hidden');
}

function versesTodayCompleted(planId){
    objPlans[planId].dayCompleted();
    saveData();
    var day = objPlans[planId].numDaysFinished();
    $.get('http://' + HOST + '/finished', { plan_id: planId, day: day, user_id: userId, user_name: userName }, function(data){});
}

function incrementMemorizedCount(){
    memorizedCount++;
    if(memorizedCount == DAILY_MEMORIZED_GOAL){
        $('#message').text('Great Job! You Should Have Memorized The Passage By Now!');
        showTicks(memorizedCount);
        memorizedCount = 0;
    }
}

function clearInput(){
    $('.missingWord').each(function(){
        $(this).val('');
    });
}

function addPlanLinkClicked(event){
    var planId = event.data.param1;
    objPlans[planId].added = true;
    htmlRender.showAddedPlans();
    versesNext();
    $('#plans-selector').hide();
    $('#passages-container, #new-plan-link').show();
    saveData();
}

function userNameSubmitClicked(){
    var name = $('#user-name').val().trim();
    if(name.length < 3) {
        alert('Your name is too short');
    }
    else {
        userName = name;
        saveData();
        $('#user-name-container').fadeOut('slow', function(){
            versesNext();
            $('#new-plan-link').show();
        });
    }
}

function feedbackCloseClicked(){
    $('#feedback').hide();
    var data = {}
    data['feedback-closed'] = '1';
//    chrome.storage.sync.set(data);
}

function helpClicked(){
    htmlRender.showFeedback();
}

function rateBackgroundClicked(){
    var avg = (getRandom(1,2)[0]+2) + '.' + getRandom(1,9)[0];
    $('#rate-background a').hide();
    $('#rate-background p').text('Thank you for rating!');
    $.get('http://' + HOST + '/usage', { usage_type: 'RATE-BG', user_id: userId, user_name: userName, details: $(this).data('rate') + '-' + bgImage });
}

function ratedBgClicked(){
    $.get('http://' + HOST + '/usage', { usage_type: 'VIEW-RATED-BG', user_id: userId, user_name: userName, details: $(this).data('rate')});
}

//function rateYesClicked(){
//    var data = {}
//    data['rated'] = 'yes';
//    chrome.storage.sync.set(data);
//    $.get('http://' + HOST + '/usage', { usage_type: 'RATE-YES', user_id: userId, user_name: userName });
//}
//
//function rateNoClicked(){
//    $('#rate-container').fadeOut();
//    var data = {}
//    data['rated'] = 'no';
//    chrome.storage.sync.set(data);
//    $.get('http://' + HOST + '/usage', { usage_type: 'RATE-NO', user_id: userId, user_name: userName });
//}

function revealClicked(){
    var usageType = '';
    var details = '';
    var timeoutLength = 0;

    var planId, day;
    planId = parseInt($(this).data('planId'));
    day = parseInt($(this).data('day'));

    if($(this).data('start-memorize')) {
        usageType = 'START_MEMORIZE';
        timeoutLength = 0;
        $('#message').empty();
        incrementMemorizedCount();
    }
    else {
        var bHint = $(this).attr('id') == 'hint-button';
        if(bHint) {
            $('.missingWord').each(function(){
                $(this).val($(this).data('answer'));
            });
            setTimeout(clearInput, 3000);
            $.get('http://' + HOST + '/usage', { usage_type: 'HINT', plan_id: $(this).data('planId'), day: $(this).data('day'), user_id: userId, user_name: userName }, function(data){});
            return;
        }

        $('#reveal-button').css('visibility', 'hidden');
        $('#hint-button').hide();

        // This part only applies if there are fill-in-the-blank
        var bAllCorrect = true;
        var correct = 0, wrong = 0;
        $('.missingWord').each(function(e){
            if($(this).val().toLowerCase().removePunctuation() == $(this).data('answer').toLowerCase().removePunctuation()){
                $(this).addClass('correct');
                correct++;
            }
            else {
                bAllCorrect = false;
                $(this).val($(this).data('answer'));
                $(this).addClass('wrong');
                wrong++;
            }
        });

        if(bAllCorrect){
            usageType = 'ANSWERED_CORRECT';
            timeoutLength = 2000;
            $('#message').empty().append('Good Job!').fadeIn('slow');
            incrementMemorizedCount();
        }
        else {
            usageType = 'ANSWERED_WRONG'
            timeoutLength = 5000;
            details = correct +'/' + wrong;
            $('#message').empty().append('Try Again in 5 Seconds!').fadeIn('slow');
//            incrementMemorizedCount();
        }
    }

    bgBlock();

    $.get('http://' + HOST + '/usage', { usage_type: usageType, details: details, plan_id: $(this).data('planId'), day: $(this).data('day'), user_id: userId, user_name: userName }, function(data){});

    timeoutVar = setTimeout(function(){
        versesNext(planId, day);
    }, timeoutLength);
}

function memorizedClicked(){
    $('#memorized-verses-container').show();
    $('#passages-container').hide();
    $.get('http://' + HOST + '/usage', { usage_type: 'MEMORIZED-OPENED', user_id: userId, user_name: userName});
}

function memorizedCloseClicked(){
    $('.popup').hide();
    $('#passages-container').show();
}

function memorizedVersesClicked(){
    $('#memorized-verses-container').hide();
    versesFetch($(this).data('plan-id'), $(this).data('plan-day'));
    $.get('http://' + HOST + '/usage', { usage_type: 'MEMORIZED-VERSES-CLICKED', user_id: userId, user_name: userName, plan_id: $(this).data('plan-id'), day: $(this).data('plan-day')});
}

$( document ).ready(function() {
    readingPlans.forEach(function(jsonPlan){
        var objPlan = new Plan(jsonPlan);
        objPlans[objPlan.id] = objPlan;
    });

//    chrome.storage.sync.get(null, function (userData) {
//        console.log(userData);
//
//        if (userData === undefined){
//            return;
//        }


    userId = 'testuser';
    userName = 'testuser';

//        for(var planId in userData["plans"]){
    objPlans['1'].added = true;
//            objPlans['1'].completedOn = userData["plans"][planId];
//        };

//        if(userData['userName'] === undefined || userData['userName'] == '') {
//            htmlRender.screenUserName();
//        }
//        else {
//            userName = userData['userName'];
//            versesNext();
//        }

    versesNext();

//        rated = userData['rated'];

//        $('#superuser-name').text(userData['userName']);
//        $('#help').show();
//    });

//    $('#feedback-close').click(feedbackCloseClicked);
//    $('#help').click(helpClicked);
    $('#reveal-button, #hint-button').click(revealClicked);
//    $('#user-name-submit').click(userNameSubmitClicked);
//    $('#rate-yes-button').click(rateYesClicked);
//    $('#rate-no-button').click(rateNoClicked);

    $('.maincontainer').on('click', '#new-plan-link', function(){
        htmlRender.screenPlanSelector();
        $('#passages-container').hide();
    });

    $('#plans-selector').on('click', '#plans-close', function(){
        $('.popup').hide();
        $('#passages-container, #new-plan-link').show();
    });

//    htmlRender.fetchUsers();
//    htmlRender.fetchBgRating();

    $('#memorized-link').click(memorizedClicked);
    $('#memorized-close').click(memorizedCloseClicked);


//    $('#add-day').click(function(){
//        var tomorrow = new Date(today);
//        tomorrow.setDate(tomorrow.getDate()+1);
//        today = formatDate(tomorrow);
//        htmlRender.showAddedPlans();
//        versesNext();
//    });

//    $('#rate1, #rate2, #rate3, #rate4, #rate5').click(rateBackgroundClicked);

    rollBg();
});
