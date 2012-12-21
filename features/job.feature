#language: ja
機能:一覧表示
	背景:
		前提 次の"job"レコードがある
		  |title|
			|hello|
			|world|
	シナリオ:一覧表示
		もし "/jobs"ページを表示する
		ならば"myTest Job"と表示されていること
		かつ"myTest Job"と表示されていること
		かつ"詳しくみる"と表示されていること

