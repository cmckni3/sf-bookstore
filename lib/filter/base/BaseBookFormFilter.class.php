<?php

/**
 * Book filter form base class.
 *
 * @package    test
 * @subpackage filter
 * @author     Your name here
 */
abstract class BaseBookFormFilter extends BaseFormFilterPropel
{
  public function setup()
  {
    $this->setWidgets(array(
      'author_id' => new sfWidgetFormPropelChoice(array('model' => 'Author', 'add_empty' => true)),
      'title'     => new sfWidgetFormFilterInput(array('with_empty' => false)),
      'year'      => new sfWidgetFormFilterInput(),
      'price'     => new sfWidgetFormFilterInput(),
    ));

    $this->setValidators(array(
      'author_id' => new sfValidatorPropelChoice(array('required' => false, 'model' => 'Author', 'column' => 'id')),
      'title'     => new sfValidatorPass(array('required' => false)),
      'year'      => new sfValidatorSchemaFilter('text', new sfValidatorInteger(array('required' => false))),
      'price'     => new sfValidatorSchemaFilter('text', new sfValidatorNumber(array('required' => false))),
    ));

    $this->widgetSchema->setNameFormat('book_filters[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    parent::setup();
  }

  public function getModelName()
  {
    return 'Book';
  }

  public function getFields()
  {
    return array(
      'id'        => 'Number',
      'author_id' => 'ForeignKey',
      'title'     => 'Text',
      'year'      => 'Number',
      'price'     => 'Number',
    );
  }
}
