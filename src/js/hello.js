service hello( { name: who } ) {
  return <html><div onclick=~{ alert( "Hi " + ${who} + "!") }>hello</div></html>;
}