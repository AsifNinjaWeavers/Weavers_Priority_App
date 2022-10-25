class PriorityController{
static bool checkupcoming(DateTime? date)
  {
    if(date==null)
    {
      return true;
    }
    DateTime datenow=DateTime.now();
    return datenow.isBefore(date);
  }
static bool checkoverdue(DateTime? date)
  {
    if(date==null)
    {
      return false;
    }
    DateTime datenow=DateTime.now();
    return datenow.isAfter(date);
  }
}