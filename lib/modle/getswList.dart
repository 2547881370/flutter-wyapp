class Autogenerated {
  String msg;
  List<Posts> posts;
  List<WeightAndTopPost> weightAndTopPost;
  Category category;
  String more;
  String start;
  String status;

  Autogenerated(
      {this.msg,
      this.posts,
      this.weightAndTopPost,
      this.category,
      this.more,
      this.start,
      this.status});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['posts'] != null) {
      posts = new List<Posts>();
      json['posts'].forEach((v) {
        posts.add(new Posts.fromJson(v));
      });
    }
    if (json['weightAndTopPost'] != null) {
      weightAndTopPost = new List<WeightAndTopPost>();
      json['weightAndTopPost'].forEach((v) {
        weightAndTopPost.add(new WeightAndTopPost.fromJson(v));
      });
    }
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    more = json['more'];
    start = json['start'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.posts != null) {
      data['posts'] = this.posts.map((v) => v.toJson()).toList();
    }
    if (this.weightAndTopPost != null) {
      data['weightAndTopPost'] =
          this.weightAndTopPost.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['more'] = this.more;
    data['start'] = this.start;
    data['status'] = this.status;
    return data;
  }
}

class Posts {
  int postID;
  String title;
  String detail;
  List<String> images;
  int score;
  String scoreTxt;
  int hit;
  int commentCount;
  int notice;
  int weight;
  int isGood;
  int createTime;
  int activeTime;
  int line;
  User user;
  Null ext;
  Null category;
  int tagid;
  int status;
  int praise;
  String voice;
  int isAuthention;
  int isRich;
  int appOrientation;
  int isAppPost;
  Null appVersion;
  int appSize;
  Null appSystem;
  Null appLogo;
  Null screenshots;
  Null appIntroduce;
  Null appUrl;
  Null appLanguage;
  int isGif;

  Posts(
      {this.postID,
      this.title,
      this.detail,
      this.images,
      this.score,
      this.scoreTxt,
      this.hit,
      this.commentCount,
      this.notice,
      this.weight,
      this.isGood,
      this.createTime,
      this.activeTime,
      this.line,
      this.user,
      this.ext,
      this.category,
      this.tagid,
      this.status,
      this.praise,
      this.voice,
      this.isAuthention,
      this.isRich,
      this.appOrientation,
      this.isAppPost,
      this.appVersion,
      this.appSize,
      this.appSystem,
      this.appLogo,
      this.screenshots,
      this.appIntroduce,
      this.appUrl,
      this.appLanguage,
      this.isGif});

  Posts.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    title = json['title'];
    detail = json['detail'];
    images = json['images'].cast<String>();
    score = json['score'];
    scoreTxt = json['scoreTxt'];
    hit = json['hit'];
    commentCount = json['commentCount'];
    notice = json['notice'];
    weight = json['weight'];
    isGood = json['isGood'];
    createTime = json['createTime'];
    activeTime = json['activeTime'];
    line = json['line'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    ext = json['ext'];
    category = json['category'];
    tagid = json['tagid'];
    status = json['status'];
    praise = json['praise'];
    voice = json['voice'];
    isAuthention = json['isAuthention'];
    isRich = json['isRich'];
    appOrientation = json['appOrientation'];
    isAppPost = json['isAppPost'];
    appVersion = json['appVersion'];
    appSize = json['appSize'];
    appSystem = json['appSystem'];
    appLogo = json['appLogo'];
    screenshots = json['screenshots'];
    appIntroduce = json['appIntroduce'];
    appUrl = json['appUrl'];
    appLanguage = json['appLanguage'];
    isGif = json['isGif'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['title'] = this.title;
    data['detail'] = this.detail;
    data['images'] = this.images;
    data['score'] = this.score;
    data['scoreTxt'] = this.scoreTxt;
    data['hit'] = this.hit;
    data['commentCount'] = this.commentCount;
    data['notice'] = this.notice;
    data['weight'] = this.weight;
    data['isGood'] = this.isGood;
    data['createTime'] = this.createTime;
    data['activeTime'] = this.activeTime;
    data['line'] = this.line;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['ext'] = this.ext;
    data['category'] = this.category;
    data['tagid'] = this.tagid;
    data['status'] = this.status;
    data['praise'] = this.praise;
    data['voice'] = this.voice;
    data['isAuthention'] = this.isAuthention;
    data['isRich'] = this.isRich;
    data['appOrientation'] = this.appOrientation;
    data['isAppPost'] = this.isAppPost;
    data['appVersion'] = this.appVersion;
    data['appSize'] = this.appSize;
    data['appSystem'] = this.appSystem;
    data['appLogo'] = this.appLogo;
    data['screenshots'] = this.screenshots;
    data['appIntroduce'] = this.appIntroduce;
    data['appUrl'] = this.appUrl;
    data['appLanguage'] = this.appLanguage;
    data['isGif'] = this.isGif;
    return data;
  }
}

class User {
  int userID;
  String nick;
  String avatar;
  int gender;
  int age;
  int role;
  int experience;
  int credits;
  String identityTitle;
  int identityColor;
  int level;
  int levelColor;
  int integral;
  int uuid;
  String integralNick;
  Null signature;
  Null medalList;

  User(
      {this.userID,
      this.nick,
      this.avatar,
      this.gender,
      this.age,
      this.role,
      this.experience,
      this.credits,
      this.identityTitle,
      this.identityColor,
      this.level,
      this.levelColor,
      this.integral,
      this.uuid,
      this.integralNick,
      this.signature,
      this.medalList});

  User.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    nick = json['nick'];
    avatar = json['avatar'];
    gender = json['gender'];
    age = json['age'];
    role = json['role'];
    experience = json['experience'];
    credits = json['credits'];
    identityTitle = json['identityTitle'];
    identityColor = json['identityColor'];
    level = json['level'];
    levelColor = json['levelColor'];
    integral = json['integral'];
    uuid = json['uuid'];
    integralNick = json['integralNick'];
    signature = json['signature'];
    medalList = json['medalList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['nick'] = this.nick;
    data['avatar'] = this.avatar;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['role'] = this.role;
    data['experience'] = this.experience;
    data['credits'] = this.credits;
    data['identityTitle'] = this.identityTitle;
    data['identityColor'] = this.identityColor;
    data['level'] = this.level;
    data['levelColor'] = this.levelColor;
    data['integral'] = this.integral;
    data['uuid'] = this.uuid;
    data['integralNick'] = this.integralNick;
    data['signature'] = this.signature;
    data['medalList'] = this.medalList;
    return data;
  }
}

class WeightAndTopPost {
  int postID;
  String title;
  String detail;
  List<String> images;
  int score;
  String scoreTxt;
  int hit;
  int commentCount;
  int notice;
  int weight;
  int isGood;
  int createTime;
  int activeTime;
  int line;
  User user;
  Null ext;
  Null category;
  int tagid;
  int status;
  int praise;
  Null voice;
  int isAuthention;
  int isRich;
  int appOrientation;
  int isAppPost;
  Null appVersion;
  int appSize;
  Null appSystem;
  Null appLogo;
  Null screenshots;
  Null appIntroduce;
  Null appUrl;
  Null appLanguage;
  int isGif;

  WeightAndTopPost(
      {this.postID,
      this.title,
      this.detail,
      this.images,
      this.score,
      this.scoreTxt,
      this.hit,
      this.commentCount,
      this.notice,
      this.weight,
      this.isGood,
      this.createTime,
      this.activeTime,
      this.line,
      this.user,
      this.ext,
      this.category,
      this.tagid,
      this.status,
      this.praise,
      this.voice,
      this.isAuthention,
      this.isRich,
      this.appOrientation,
      this.isAppPost,
      this.appVersion,
      this.appSize,
      this.appSystem,
      this.appLogo,
      this.screenshots,
      this.appIntroduce,
      this.appUrl,
      this.appLanguage,
      this.isGif});

  WeightAndTopPost.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    title = json['title'];
    detail = json['detail'];
    images = json['images'].cast<String>();
    score = json['score'];
    scoreTxt = json['scoreTxt'];
    hit = json['hit'];
    commentCount = json['commentCount'];
    notice = json['notice'];
    weight = json['weight'];
    isGood = json['isGood'];
    createTime = json['createTime'];
    activeTime = json['activeTime'];
    line = json['line'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    ext = json['ext'];
    category = json['category'];
    tagid = json['tagid'];
    status = json['status'];
    praise = json['praise'];
    voice = json['voice'];
    isAuthention = json['isAuthention'];
    isRich = json['isRich'];
    appOrientation = json['appOrientation'];
    isAppPost = json['isAppPost'];
    appVersion = json['appVersion'];
    appSize = json['appSize'];
    appSystem = json['appSystem'];
    appLogo = json['appLogo'];
    screenshots = json['screenshots'];
    appIntroduce = json['appIntroduce'];
    appUrl = json['appUrl'];
    appLanguage = json['appLanguage'];
    isGif = json['isGif'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['title'] = this.title;
    data['detail'] = this.detail;
    data['images'] = this.images;
    data['score'] = this.score;
    data['scoreTxt'] = this.scoreTxt;
    data['hit'] = this.hit;
    data['commentCount'] = this.commentCount;
    data['notice'] = this.notice;
    data['weight'] = this.weight;
    data['isGood'] = this.isGood;
    data['createTime'] = this.createTime;
    data['activeTime'] = this.activeTime;
    data['line'] = this.line;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['ext'] = this.ext;
    data['category'] = this.category;
    data['tagid'] = this.tagid;
    data['status'] = this.status;
    data['praise'] = this.praise;
    data['voice'] = this.voice;
    data['isAuthention'] = this.isAuthention;
    data['isRich'] = this.isRich;
    data['appOrientation'] = this.appOrientation;
    data['isAppPost'] = this.isAppPost;
    data['appVersion'] = this.appVersion;
    data['appSize'] = this.appSize;
    data['appSystem'] = this.appSystem;
    data['appLogo'] = this.appLogo;
    data['screenshots'] = this.screenshots;
    data['appIntroduce'] = this.appIntroduce;
    data['appUrl'] = this.appUrl;
    data['appLanguage'] = this.appLanguage;
    data['isGif'] = this.isGif;
    return data;
  }
}
class Category {
  int categoryID;
  int model;
  String title;
  String icon;
  String description;
  int postCount;
  int viewCount;
  String postCountFormated;
  String viewCountFormated;
  int isGood;
  int isSubscribe;
  int hide;
  int seq;
  int subscribeType;
  int forumid;
  String cateRule;
  String type;
  String wap;
  int appId;
  List<Moderator> moderator;
  List<Tags> tags;
  String isSearch;
  int hasChild;
  int pid;

  Category(
      {this.categoryID,
      this.model,
      this.title,
      this.icon,
      this.description,
      this.postCount,
      this.viewCount,
      this.postCountFormated,
      this.viewCountFormated,
      this.isGood,
      this.isSubscribe,
      this.hide,
      this.seq,
      this.subscribeType,
      this.forumid,
      this.cateRule,
      this.type,
      this.wap,
      this.appId,
      this.moderator,
      this.tags,
      this.isSearch,
      this.hasChild,
      this.pid});

  Category.fromJson(Map<String, dynamic> json) {
    categoryID = json['categoryID'];
    model = json['model'];
    title = json['title'];
    icon = json['icon'];
    description = json['description'];
    postCount = json['postCount'];
    viewCount = json['viewCount'];
    postCountFormated = json['postCountFormated'];
    viewCountFormated = json['viewCountFormated'];
    isGood = json['isGood'];
    isSubscribe = json['isSubscribe'];
    hide = json['hide'];
    seq = json['seq'];
    subscribeType = json['subscribeType'];
    forumid = json['forumid'];
    cateRule = json['cateRule'];
    type = json['type'];
    wap = json['wap'];
    appId = json['appId'];
    if (json['moderator'] != null) {
      moderator = new List<Moderator>();
      json['moderator'].forEach((v) {
        moderator.add(new Moderator.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    isSearch = json['isSearch'];
    hasChild = json['hasChild'];
    pid = json['pid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryID'] = this.categoryID;
    data['model'] = this.model;
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['description'] = this.description;
    data['postCount'] = this.postCount;
    data['viewCount'] = this.viewCount;
    data['postCountFormated'] = this.postCountFormated;
    data['viewCountFormated'] = this.viewCountFormated;
    data['isGood'] = this.isGood;
    data['isSubscribe'] = this.isSubscribe;
    data['hide'] = this.hide;
    data['seq'] = this.seq;
    data['subscribeType'] = this.subscribeType;
    data['forumid'] = this.forumid;
    data['cateRule'] = this.cateRule;
    data['type'] = this.type;
    data['wap'] = this.wap;
    data['appId'] = this.appId;
    if (this.moderator != null) {
      data['moderator'] = this.moderator.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['isSearch'] = this.isSearch;
    data['hasChild'] = this.hasChild;
    data['pid'] = this.pid;
    return data;
  }
}

class Moderator {
  int userID;
  String nick;
  String avatar;
  Null identityTitle;
  int leveColor;

  Moderator(
      {this.userID,
      this.nick,
      this.avatar,
      this.identityTitle,
      this.leveColor});

  Moderator.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    nick = json['nick'];
    avatar = json['avatar'];
    identityTitle = json['identityTitle'];
    leveColor = json['leveColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['nick'] = this.nick;
    data['avatar'] = this.avatar;
    data['identityTitle'] = this.identityTitle;
    data['leveColor'] = this.leveColor;
    return data;
  }
}

class Tags {
  int iD;
  String name;

  Tags({this.iD, this.name});

  Tags.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['name'] = this.name;
    return data;
  }
}