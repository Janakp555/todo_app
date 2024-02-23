import 'package:flutter/material.dart';
import 'package:todo/todo_item.dart';
import '../todo.dart';


class hom extends  StatefulWidget{
  @override
  State<hom> createState() => _homState();
}

class _homState extends State<hom> {
  final todoList = Todo.todoList();
  List<Todo>_foundTodo =[];
  final _todoController = TextEditingController();
  @override

  void initState(){
    _foundTodo = todoList;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50,bottom: 20),
                        child: Text('All ToDos',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
                      ),
                      for(Todo todo in _foundTodo.reversed)
                      todo_item(todo: todo,
                      onTodoChanged: _hanaleTodochange,
                        onDeleteItem: _deleteTodoItem,
                      ),


                    ],
                  ),
                )
            ],
            )
          ),
          Align(alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(child: Container(
                margin: EdgeInsets.only(bottom: 5,right: 10,left:10, ),
                padding: EdgeInsets.symmetric(horizontal: 20,),
                decoration:BoxDecoration(
                  color: Colors.white,
                  boxShadow: const[BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0,0.0),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                  ),],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _todoController,
                  decoration: InputDecoration(
                    hintText: "Add a new todo list",
                    border: InputBorder.none
                  ),
                ),
              )),
              Container(
                margin: EdgeInsets.only(bottom: 10,right: 20),
                child: ElevatedButton(child:Text('+',style: TextStyle(fontSize: 35,),),
                onPressed: (){
                  _addTodoItem(_todoController.text);
                },
                style: ElevatedButton.styleFrom(
                 primary: Colors.blue,
                 minimumSize: Size(40, 40),
                 elevation: 0,
                 ),
              ),
            ),
           ]),
          ),
        ],
      )
    );
  }


  void _hanaleTodochange(Todo todo){
    setState(() {
      todo.isDone =! todo.isDone;
    });

  }

  void _deleteTodoItem(String id){
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }


  void _addTodoItem(String todo){
    setState(() {
      todoList.add(Todo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: todo,
      ));
    });
    _todoController.clear();
  }

  void _runfilter(String enteredKeyword){
    List<Todo> results = [];
    if(enteredKeyword.isEmpty){
      results = todoList;
    }
    else{
      results = todoList.where((item) => item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();

      setState(() {
        _foundTodo = results;
      });
    }
  }


  Widget searchBox(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (value) => _runfilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search,color: Colors.grey.shade200,size: 20,),
          prefixIconConstraints: BoxConstraints(
            minHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'search',
          hintStyle: TextStyle(color: Colors.grey.shade200),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor:Colors.grey.shade200,
      elevation: 0,
      title: Row(
        children: [
          Icon(Icons.menu,color: Colors.black54,size: 34,)

        ],
      ),
    );
  }
}




