<?php

/**
 * Author form.
 *
 * @package    test
 * @subpackage form
 * @author     Your name here
 */
class AuthorForm extends BaseAuthorForm
{
  public function configure()
  {
    $this->mergeRelation('Book');
/*     $this->embedRelation('Book'); */
  }
}
