(Teapot configure: { #port -> 8080 })
    GET:  '/*' -> [:req | DateAndTime now printString ];
    start.

"Suspend UI process, not needed on headless"
(Process allSubInstances reject: #isTerminated)
	detect: [ :process | process name includesSubstring: 'UI Process' ]
	ifFound: [ :process | process suspend ].
Processor activeProcess suspend.

