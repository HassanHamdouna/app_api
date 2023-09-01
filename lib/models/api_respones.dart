class ApiRespones<T>{
  final String message;
  final bool status;
  T? object;

  ApiRespones(this.message, this.status,[this.object]);
}