(import oop)

(define (valid-src? src)
  ;; src 是一个字符串,长下面这样:
  ;; xxx/xxx/xxx 
  ;; /xxx/xxxx/xxx
  ;; /xxx/xxx/
  ;; 判断所有xxx不能带有冒号, 不能是.或..
  body)

(define (get-scheme uri)
  ;; uri是 aaaaa://bbbbbb/ccccc....
  ;; 返回aaaaa的值
  body)
(define (get-authority uri)
  ;; uri是 aaaaa://bbbbbb/ccccc....
  ;; 返回bbbbb的值可能为空或带冒号
  body)

(define (get-base-uri uri)
  ;; uri是 aaaaa://bbbb/cccccc....(bbbb可能为空字符串)
  ;;    或 aaaaa://bbbb:ccc/dddddd
  ;; 返回 aaaaa://bbbb/ 或 aaaaa://bbbbb:ccc/
  body)


(define-class (abstract-file-system uri config) 
              (<base>)
  (ivars statistics [uri uri] default-port)
  (inherited)
  (inheritable)
  (private)
  (protected)
  (public 
    (valid-path? (path)
      ;; 相对路径不行
      ;; (get-scheme path) 为空的话,
      ;; (get-authority path) 也必须空
      ;; 如果不为空, 必须跟 uri的scheme和authority一致(不分大小写)
      ;; 如果path的port不是-1, 必须跟uri的port一样
      (,,,))))
     
       






