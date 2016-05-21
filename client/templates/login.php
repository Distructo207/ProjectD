---
name: login
url: /login
---
	<link rel="stylesheet" href="css/foundation.css">
    <link rel="stylesheet" href="css/app.css">
	<div class="grid-blocks">
	<p><a class="lead" href="http://helenpark.nl">
      <img src="http://helenpark.nl/images/logo-helen-parkhurst.png"></p></a>
      </div>
 	 <div class="login">
	<h1>Login</h1>
    <form method="post" action="home.php">
    	<input type="text" name="username" placeholder="Username" required="required" />
        <input type="password" name="password" placeholder="Password" required="required" />
        <input type="radio" name="type" value="student">Student</input><input type="radio" name="type" value="staff">staff</input>
        <button type="submit" class="btn btn-primary btn-block btn-large">LOGIN</button>
    </form>
    </div>
</div>